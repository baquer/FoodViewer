 //
//  ProductTableViewController.swift
//  FoodViewer
//
//  Created by arnaud on 31/01/16.
//  Copyright © 2016 Hovering Above. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController, UITextFieldDelegate {

    private var products: [FoodProduct] = []
    
    private var storedHistory = History()
    
    // This variable is needed to keep track of the asynchrnous interet retrievals
    private var historyHasBeenLoaded: Int? = nil {
        didSet {
            if let currentLoadHistory = historyHasBeenLoaded {
                if currentLoadHistory == storedHistory.barcodes.count {
                    // all products have been loaded from history
                    historyHasBeenLoaded = nil
                    refreshInterface()
                    // This should happen only once?
                    // It is possible that at this stage the relevant product data has not been loaded yet
                    // performSegueWithIdentifier(Storyboard.ToPageViewControllerSegue, sender: self)
                    // scroll to the top product in the tableview
                }
            }
        }
    }
    
    private var barcode: BarcodeType? = nil {
        didSet {
            // get the corresponding data from OFF
            fetchProduct(barcode)
        }
    }
    
    private func fetchProduct(barcode: BarcodeType?) {
        if barcode != nil {
            let request = OpenFoodFactsRequest()
            // loading the product from internet will be done off the main queue
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                let fetchResult = request.fetchProductForBarcode(barcode!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    switch fetchResult {
                    case .Success(let newProduct):
                        self.updateProduct(newProduct)
                        self.refreshInterface()
                    case .Error(let error):
                        let alert = UIAlertController(
                            title: Constants.AlertSheetMessage,
                            message: error, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: Constants.AlertSheetActionTitle, style: .Cancel) { (action: UIAlertAction) -> Void in // do nothing )
                            }
                        )
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                })
            })
        }
    }

    private func refreshInterface() {
        if products.count > 0 {
            selectedProduct = products.first
            tableView.reloadData()
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: false)
        }
    }
    
    private func updateProduct(product: FoodProduct?) {
        if let productToUpdate = product {
            // should check if the product is not already available
            if !products.isEmpty {
                // look at all products
                var indexExistingProduct: Int? = nil
                for index in 0 ..< products.count {
                    // print("products \(products[index].barcode.asString()); update \(productToUpdate.barcode.asString())")
                    if products[index].barcode.asString() == productToUpdate.barcode.asString() {
                        indexExistingProduct = index
                    }
                }
                if indexExistingProduct == nil {
                    // new product not yet in products array
                    // print("ADD product \(productToUpdate.barcode.asString())")
                    self.products.insert(productToUpdate, atIndex: 0)
                    refreshInterface()
                    tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: false)
                    // add product barcode to history
                    self.storedHistory.addBarcode(barcode: productToUpdate.barcode.asString())
                } else {
                    // print("UPDATE product \(productToUpdate.barcode.asString())")
                    // reset product information to the retrieved one
                    self.products[indexExistingProduct!] = productToUpdate
                    if historyHasBeenLoaded != nil {
                        historyHasBeenLoaded! += 1
                    }
                }
            } else {
                // print("FIRST product \(productToUpdate.barcode.asString())")
                
                // this is the first product of the array
                products.append(productToUpdate)
                // add product barcode to history
                self.storedHistory.addBarcode(barcode: productToUpdate.barcode.asString())
            }
            // launch image retrieval if needed
            if (productToUpdate.mainUrl != nil) {
                if (productToUpdate.mainImageData == nil) {
                    // get image only if the data is not there yet
                    self.retrieveImage(productToUpdate.mainUrl!)
                }
            }
        }
    }
    
    private func retrieveImage(url: NSURL?) {
        if let imageURL = url {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                do {
                    // This only works if you add a line to your Info.plist
                    // See http://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http
                    //
                    let imageData = try NSData(contentsOfURL: imageURL, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                    if imageData.length > 0 {
                        // if we have the image data we can go back to the main thread
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            // set the received image data
                            // as we are on another thread I should find the product to add it to
                            if !self.products.isEmpty {
                                // look at all products
                                var indexExistingProduct: Int? = nil
                                for index in 0 ..< self.products.count {
                                    if self.products[index].mainUrl == imageURL {
                                        indexExistingProduct = index
                                    }
                                }
                                if indexExistingProduct != nil {
                                    self.products[indexExistingProduct!].mainImageData = imageData
                                }
                                self.refreshInterface()
                            } // else bad luck corresponding product is no longer there
                        })
                    }
                }
                catch {
                    print(error)
                }
            })
        }
    }
    
    private struct Constants {
        static let ViewControllerTitle = NSLocalizedString("Products", comment: "Title of ViewController with a list of all products that has been viewed.")
        static let AlertSheetMessage = NSLocalizedString("Error retrieving product", comment: "Alert message, when the product could not be retrieved from Internet.")
        static let AlertSheetActionTitle = NSLocalizedString("Pity", comment: "Alert title, to indicate retrieving product did not work")
        static let NoProductsInHistory = NSLocalizedString("No products listed", comment: "Text to indicate that the history of products is empty.")
        static let ProductNameMissing = NSLocalizedString("No product name", comment: "Text in header of section, indicating that the product name is missing.")
        static let NumberOfNutritionalFactsText = NSLocalizedString("%@ nutritional facts specified", comment: "Cell text for the total number of nutritional facts available.")
    }
    
    var productPageViewController: ProductPageViewController? = nil
    
    // MARK: - Actions
    
    // MARK: - TextField Methods

    let button = UIButton(type: UIButtonType.Custom)

    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.keyboardType = .NumberPad
            if let searchText = barcode?.asString() {
                searchTextField.text = searchText
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            if let searchText = textField.text {
                barcode = BarcodeType(value:searchText)
            }
        }
        return true
    }
    
    func keyboardReturnButton() {
    
        button.setTitle("Return", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 163, 106, 53)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(ProductTableViewController.Done(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }

    func Done(sender : UIButton){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.searchTextField.resignFirstResponder()
        }
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProductTableViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }

    
    // http://iosdevcenters.blogspot.com/2016/01/how-to-adding-return-key-in-number.html
    //
    func keyboardWillShow(note : NSNotification) -> Void{
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.button.hidden = false
            let keyBoardWindow = UIApplication.sharedApplication().windows.last
            let doneButtonXCoordinates = (keyBoardWindow?.frame.size.width)! * CGFloat(0.33125)
            self.button.frame = CGRectMake(0, (keyBoardWindow?.frame.size.height)!-53, doneButtonXCoordinates, 53)
            keyBoardWindow?.addSubview(self.button)
            keyBoardWindow?.bringSubviewToFront(self.button)
            UIView.animateWithDuration(((note.userInfo! as NSDictionary).objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.doubleValue)!, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.view.frame = CGRectOffset(self.view.frame, 0, 0)
                }, completion: { (complete) -> Void in
                    // print("Complete")
            })
        }
    }


    // MARK: - Table view methods and vars
    
    private var selectedProduct: FoodProduct? = nil {
        didSet {
            if selectedIndex == nil {
                selectedIndex = 0
            }
            showSelectedProduct()
        }
    }
    
    private var previousProduct: FoodProduct? = nil
    
    private var selectedIndex: Int? = nil // this indicates which part of the product must be shown
    
    private func showSelectedProduct() {
        // prevent that to many changes are pushed on the view stack
        // check the current presented controller
        // only segue if we are at the top of the stack
        // i.e. only segue once
        if let parentVC = self.parentViewController as? UINavigationController {
            if let _ = parentVC.visibleViewController as? ProductTableViewController {
                performSegueWithIdentifier(Storyboard.ToPageViewControllerSegue, sender: self)
            }
        }
    }

    private enum RowType {
        case Name
        case Ingredients
        case NutritionFacts
        case NutritionScore
        case Categories
        case Completion
        case SupplyChain
    }

    // defines the order of the rows
    private var tableStructure: [RowType] = [.Name, .Ingredients, .NutritionFacts, .SupplyChain, .Categories, .Completion, .NutritionScore]

    private struct Storyboard {
        static let NameCellIdentifier = "Product Name Cell"
        static let IngredientsCellIdentifier = "Product Ingredients Cell"
        static let CountriesCellIdentifier = "Countries Cell"
        static let NutritionFactsCellIdentifier = "Product Nutrition Facts Name Cell"
        static let NutritionScoreCellIdentifier = "Product Nutrition Score Cell"
        static let CategoriesCellIdentifier = "Product Categories Cell"
        static let CompletionCellIdentifier = "Product Completion State Cell"
        static let ProducerCellIdentifier = "Product Producer Cell"
        static let ToPageViewControllerSegue = "Show Page Controller"
        static let ShowSettingsSegueIdentifier = "Show Settings"
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // number of section depends on the existence of the data
        return products.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let currentProductSection = tableStructure[indexPath.row]
        let currentProduct = products[indexPath.section]
        
        // we assume that product exists
        switch currentProductSection {
        case .Name:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NameCellIdentifier, forIndexPath: indexPath) as! NameTableViewCell
            cell.productBrand = currentProduct.brandsArray
            if currentProduct.mainImageData?.length > 0 {
                cell.productImage = UIImage(data:currentProduct.mainImageData!)
            } else {
                cell.productImage = nil
            }
            return cell
        case .Ingredients:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.IngredientsCellIdentifier, forIndexPath: indexPath) as! IngredientsTableViewCell
            cell.product = currentProduct
            return cell
        case .NutritionFacts:
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NutritionFactsCellIdentifier, forIndexPath: indexPath)
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .DecimalStyle
                let formattedCount = formatter.stringFromNumber(currentProduct.nutritionFacts.count)
                
                cell.textLabel!.text = String.localizedStringWithFormat(Constants.NumberOfNutritionalFactsText, formattedCount!)
                return cell
        case .NutritionScore:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NutritionScoreCellIdentifier, forIndexPath: indexPath) as? NutritionScoreTableViewCell
            cell?.product = currentProduct
            return cell!
        case .Categories:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CategoriesCellIdentifier, forIndexPath: indexPath) as? CategoriesTableViewCell
            cell?.product = currentProduct
            return cell!
        case .Completion:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CompletionCellIdentifier, forIndexPath: indexPath) as? CompletionTableViewCell
            cell?.product = currentProduct
            return cell!
        case .SupplyChain:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.ProducerCellIdentifier, forIndexPath: indexPath) as? ProducerTableViewCell
            cell?.product = currentProduct
            return cell!
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStructure.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row < 6 {
            // row 6 is the nutritional score, which has no correponding page
            selectedIndex = indexPath.row
            selectedProduct = products[indexPath.section]
            // performSegueWithIdentifier(Storyboard.ToPageViewControllerSegue, sender: self)
        }
    }
   
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if products.isEmpty {
            return Constants.NoProductsInHistory
        } else {
            return products[section].name != nil ? products[section].name : Constants.ProductNameMissing
        }
    }

    // http://stackoverflow.com/questions/25902288/detected-a-case-where-constraints-ambiguously-suggest-a-height-of-zero
    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - Scene changes
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Storyboard.ToPageViewControllerSegue:
                if let vc = segue.destinationViewController as? UINavigationController {
                    if let ppvc = vc.topViewController as? ProductPageViewController {
                        ppvc.product = selectedProduct
                        if let index = selectedIndex {
                            ppvc.pageIndex = index
                        }
                    }
                }
            case Storyboard.ShowSettingsSegueIdentifier:
                if let vc = segue.destinationViewController as? SettingsTableViewController {
                        vc.storedHistory = storedHistory
                }

            default: break
            }
        }
    }

    @IBAction func unwindForCancel(segue:UIStoryboardSegue) {
        if let _ = segue.sourceViewController as? BarcodeScanViewController {
            if products.count > 0 {
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func unwindNewSearch(segue:UIStoryboardSegue) {
        if let vc = segue.sourceViewController as? BarcodeScanViewController {
            barcode = BarcodeType(typeCode:vc.type, value:vc.barcode)
            searchTextField.text = vc.barcode
        }
    }
    
    @IBAction func settingsDone(segue:UIStoryboardSegue) {
        if let _ = segue.sourceViewController as? SettingsTableViewController {
            storedHistory = History()
            products = []
        }
    }


    // MARK: - Viewcontroller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80.0
        
        if products.isEmpty {
            // check if there is history available
            // and init products with History
            if !storedHistory.barcodes.isEmpty {
                historyHasBeenLoaded = 0
                for storedBarcode in storedHistory.barcodes {
                    // this fills the database of products
                    let newProduct = FoodProduct(withBarcode: BarcodeType(value: storedBarcode))
                    // create empty products for each barcode in history
                    products.append(newProduct)
                    // fetch the corresponding data from internet
                    fetchProduct(newProduct.barcode)
                }
            } else {
                historyHasBeenLoaded = nil
            }
            // performSegueWithIdentifier(Storyboard.ToPageViewControllerSegue, sender: self)
        }
        
        keyboardReturnButton()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        title = Constants.ViewControllerTitle
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        super.viewDidDisappear(animated)
    }
}


