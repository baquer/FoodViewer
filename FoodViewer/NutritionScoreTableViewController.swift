//
//  NutritionScoreTableViewController.swift
//  FoodViewer
//
//  Created by arnaud on 08/06/16.
//  Copyright © 2016 Hovering Above. All rights reserved.
//

import UIKit

class NutritionScoreTableViewController: UITableViewController {
    
    private var showNutritionalScore: NutritionalScoreType = .UK
    
    private enum NutritionalScoreType {
        case UK
        case France
    }
    var product: FoodProduct? {
        didSet {
            if product != nil {
                refreshProduct()
            }
        }
    }
    
    private struct Constants {
        static let TitleForSectionWithBadNutrients = NSLocalizedString("Bad nutrients", comment: "Header for a table section showing the appreciations of the bad nutrients")
        static let TitleForSectionWithGoodNutrients = NSLocalizedString("Good nutrients", comment: "Header for a table section showing the appreciations of the good nutrients")
        static let TitleForSectionWithExceptionCategory = NSLocalizedString("Special categories", comment: "Header for a table section showing the special categories")
        static let TitleForSectionWithResultUK = NSLocalizedString("Nutritional Score UK", comment: "Header for a table section showing the total results UK")
        static let TitleForSectionWithResultFrance = NSLocalizedString("Nutritional Score France", comment: "Header for a table section showing the total results France")
        static let CheesesCategory = NSLocalizedString("Cheeses category", comment: "Cell title indicating the product belongs to the cheeses category")
        static let BeveragesCategory = NSLocalizedString("Beverages category", comment: "Cell title indicating the product belongs to the beverages category")
    }

    private struct Storyboard {
        static let NutrimentScoreCellIdentifier = "Nutriment Score Cell"
        static let BelongsToCategoryCellIdentifier = "Product Category Cell"
        static let ColourCodedNutritionalScoreCellIdentifier = "Colour Coded Nutritional Score Cell"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        switch showNutritionalScore {
        case .UK:
            return 3
        case .France:
            return 4
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch showNutritionalScore {
        case .UK:
            switch section {
            // section with bad nutriments
            case 0:
                return product != nil ? product!.nutritionalScoreUK.pointsA.count : 0
            // section with good nutriments
            case 1:
                return product != nil ? product!.nutritionalScoreUK.pointsC.count : 0
            default:
                return 1
            } 

        case .France:
            switch section {
            // section with bad nutriments
            case 0:
                return product != nil ? product!.nutritionalScoreFrance.pointsA.count : 0
            // section with good nutriments
            case 1:
                return product != nil ? product!.nutritionalScoreFrance.pointsC.count : 0
            case 2:
                return 2
            default:
                return 1
            } 

        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch showNutritionalScore {
        case .UK:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NutrimentScoreCellIdentifier, forIndexPath: indexPath)as? NutrimentScoreTableViewCell
                cell!.nutrimentScore = (product!.nutritionalScoreUK.pointsA[indexPath.row].nutriment, product!.nutritionalScoreUK.pointsA[indexPath.row].points, 10, 0)
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NutrimentScoreCellIdentifier, forIndexPath: indexPath)as? NutrimentScoreTableViewCell
                cell!.nutrimentScore = (product!.nutritionalScoreUK.pointsC[indexPath.row].nutriment, product!.nutritionalScoreUK.pointsC[indexPath.row].points, 5, 0)
                return cell!
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.ColourCodedNutritionalScoreCellIdentifier, forIndexPath: indexPath)as? ColourCodedNutritionalScoreTableViewCell
                cell!.score = product!.nutritionalScoreUK.total
                return cell!
            }
        case .France:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NutrimentScoreCellIdentifier, forIndexPath: indexPath)as? NutrimentScoreTableViewCell
                cell!.nutrimentScore = (product!.nutritionalScoreFrance.pointsA[indexPath.row].nutriment, product!.nutritionalScoreFrance.pointsA[indexPath.row].points, 10, 0)
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.NutrimentScoreCellIdentifier, forIndexPath: indexPath)as? NutrimentScoreTableViewCell
                cell!.nutrimentScore = (product!.nutritionalScoreFrance.pointsC[indexPath.row].nutriment, product!.nutritionalScoreFrance.pointsC[indexPath.row].points, 5, 0)
                return cell!
            case 2:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.BelongsToCategoryCellIdentifier, forIndexPath: indexPath)as? ProductCategoryTableViewCell
                    cell!.belongsToCategory = product!.nutritionalScoreFrance.cheese
                    cell!.belongsToCategoryTitle = Constants.CheesesCategory
                    return cell!
                default:
                    let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.BelongsToCategoryCellIdentifier, forIndexPath: indexPath)as? ProductCategoryTableViewCell
                    cell!.belongsToCategory = product!.nutritionalScoreFrance.beverage
                    cell?.belongsToCategoryTitle = Constants.BeveragesCategory
                    return cell!
                }
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.ColourCodedNutritionalScoreCellIdentifier, forIndexPath: indexPath)as? ColourCodedNutritionalScoreTableViewCell
                cell!.score = product!.nutritionalScoreFrance.total
                return cell!
            }
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch showNutritionalScore {
        case .UK:
            switch section {
            case 0:
                return Constants.TitleForSectionWithBadNutrients
            case 1:
                return Constants.TitleForSectionWithGoodNutrients
            default:
                return Constants.TitleForSectionWithResultUK
            }

        case .France:
            switch section {
            case 0:
                return Constants.TitleForSectionWithBadNutrients
            case 1:
                return Constants.TitleForSectionWithGoodNutrients
            case 2:
                return Constants.TitleForSectionWithExceptionCategory
            default:
                return Constants.TitleForSectionWithResultFrance
            }

        }
    }
    
    func refreshProduct() {
        tableView.reloadData()
    }

    func doubleTapOnTableView(recognizer: UITapGestureRecognizer) {
        /////
        showNutritionalScore = showNutritionalScore == .UK ? .France : .UK
        tableView.reloadData()
    }

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableStructure = setupSections()
        // self.tableView.estimatedRowHeight = 88.0
        tableView.rowHeight = UITableViewAutomaticDimension
        showNutritionalScore = .UK
        let doubleTapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:#selector(NutritionScoreTableViewController.doubleTapOnTableView))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.numberOfTouchesRequired = 1
        doubleTapGestureRecognizer.cancelsTouchesInView = false
        doubleTapGestureRecognizer.delaysTouchesBegan = true;      //Important to add
        tableView.addGestureRecognizer(doubleTapGestureRecognizer)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if product != nil {
            refreshProduct()
        }
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        OFFProducts.manager.flushImages()
    }
    

}