//
//  ProductionTableViewController.swift
//  FoodViewer
//
//  Created by arnaud on 14/02/16.
//  Copyright © 2016 Hovering Above. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class SupplyChainTableViewController: UITableViewController, TagListViewDelegate {
    
    var product: FoodProduct? {
        didSet {
            if product != nil {
                tableStructureForProduct = analyseProductForTable(product!)
                refreshProduct()
            }
        }
    }
    
    fileprivate var tableStructureForProduct: [(SectionType, Int, String?)] = []
    
    fileprivate enum SectionType {
        case ingredientOrigin
        case producer
        case producerCode
        case location
        case store
        case country
        case map
        case expirationDate
        case sites
    }
    
    fileprivate struct Constants {
        // static let DefaultHeader = "No Header"
        static let ViewControllerTitle = NSLocalizedString("Supply Chain", comment: "Title for the view controller with information about the Supply Chain (origin ingredients, producer, shop, locations).")
        static let NoExpirationDate = NSLocalizedString("No expiration date", comment: "Title of cell when no expiration date is avalable")
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        if refreshControl!.isRefreshing {
            OFFProducts.manager.reload(product!)
            refreshControl?.endRefreshing()
        }
    }
    
    
    fileprivate struct Storyboard {
        static let CellIdentifier = "TagListView Cell"
        static let CountriesCellIdentifier = "Countries TagListView Cell"
        static let ProducerCodeCellIdentifier = "ProducerCodes TagListView Cell"
        static let ExpirationDateCellIdentifier = "Expiration Date Cell"
        static let SitesCellIdentifier = "Sites TagListView Cell"
        static let MapCellIdentifier = "Map Cell"
    }
    

    fileprivate struct TableStructure {
        static let ProducerSectionHeader = NSLocalizedString("Producers", comment: "Header for section of tableView with information of the producer (name, geographic location).")
        static let ProducerCodeSectionHeader = NSLocalizedString("Producer Codes", comment: "Header for section of tableView with codes for the producer (EMB 123456 or FR.666.666).")
        static let IngredientOriginSectionHeader = NSLocalizedString("Origin ingredient", comment: "Header for section of tableView with location(s) of ingredients.")
        static let LocationSectionHeader = NSLocalizedString("Purchase Locations", comment: "Header for section of tableView with Locations where the product was bought.")
        static let CountriesSectionHeader = NSLocalizedString("Sales Countries", comment: "Header for section of tableView with Countries where the product is sold.")
        static let StoresSectionHeader = NSLocalizedString("Sale Stores", comment: "Header for section of tableView with names of the stores where the product is sold.")
        static let MapSectionHeader = NSLocalizedString("Map", comment: "Header for section of tableView with a map of producer, origin and shop locations.")
        static let ExpirationDateSectionHeader = NSLocalizedString("Expiration Date", comment: "Header title of the tableview section, indicating the most recent expiration date.")
        static let SitesSectionHeader = NSLocalizedString("Producer Sites", comment: "Header title of tableview section, indicating the sites for the product")
        static let ProducerSectionSize = 1
        static let ProducerCodeSectionSize = 1
        static let IngredientOriginSectionSize = 1
        static let LocationSectionSize = 1
        static let CountriesSectionSize = 1
        static let StoresSectionSize = 1
        static let MapSectionSize = 1
        static let ExpirationDateSectionSize = 1
        static let SitesSectionSize = 1
    }
    
    fileprivate func analyseProductForTable(_ product: FoodProduct) -> [(SectionType,Int, String?)] {
        // This function analyses to product in order to determine
        // the required number of sections and rows per section
        // The returnValue is an array with sections
        // And each element is a tuple with the section type and number of rows
        //
        var sectionsAndRows: [(SectionType,Int, String?)] = []
        
        // ingredient origin section
        sectionsAndRows.append((
            SectionType.ingredientOrigin,
            TableStructure.IngredientOriginSectionSize,
            TableStructure.IngredientOriginSectionHeader))
        // producer section
        sectionsAndRows.append((
            SectionType.producer,
            TableStructure.ProducerSectionSize,
            TableStructure.ProducerSectionHeader))
        // producer codes section
        sectionsAndRows.append((
            SectionType.producerCode,
            TableStructure.ProducerCodeSectionSize,
            TableStructure.ProducerCodeSectionHeader))
        // producer sites
        sectionsAndRows.append((
            SectionType.sites,
            TableStructure.SitesSectionSize,
            TableStructure.SitesSectionHeader))
        // purchase Location section
        sectionsAndRows.append((
            SectionType.location,
            TableStructure.LocationSectionSize,
            TableStructure.LocationSectionHeader))
        sectionsAndRows.append((
            SectionType.expirationDate,
            TableStructure.ExpirationDateSectionSize,
            TableStructure.ExpirationDateSectionHeader))
        // countries section
        sectionsAndRows.append((
            SectionType.country,
            TableStructure.CountriesSectionSize,
            TableStructure.CountriesSectionHeader))
        // stores section
        sectionsAndRows.append((
            SectionType.store,
            TableStructure.StoresSectionSize,
            TableStructure.StoresSectionHeader))
        sectionsAndRows.append((
            SectionType.map,
            TableStructure.MapSectionSize,
            TableStructure.MapSectionHeader))

        return sectionsAndRows
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableStructureForProduct.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let (_, numberOfRows, _) = tableStructureForProduct[section]
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let (currentProductSection, _, _) = tableStructureForProduct[(indexPath as NSIndexPath).section]
        
        // we assume that product exists
        switch currentProductSection {
        case .producer:
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CellIdentifier, for: indexPath) as! TagListViewTableViewCell
            cell.tagList = product!.producer?.elements
            return cell
        case .producerCode:
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ProducerCodeCellIdentifier, for: indexPath) as! AddressTagListTableViewCell
            cell.tagList = product!.producerCode
            return cell
        case .sites:
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.SitesCellIdentifier, for: indexPath) as! SitesTagListTableViewCell
            cell.tagList = product!.links
            cell.tagListView!.delegate = self
            return cell
        case .ingredientOrigin:
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CellIdentifier, for: indexPath) as! TagListViewTableViewCell
            cell.tagList = product!.ingredientsOrigin?.elements
            return cell
        case .store:
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CellIdentifier, for: indexPath) as! TagListViewTableViewCell
            cell.tagList = product!.stores
            return cell
        case .location:
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CellIdentifier, for: indexPath) as! TagListViewTableViewCell
            cell.tagList = product!.purchaseLocation?.elements
            return cell
        case .country:
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CountriesCellIdentifier, for: indexPath) as! CountriesTagListViewTableViewCell
            cell.tagList = product!.countries
            return cell
        case .map:
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.MapCellIdentifier, for: indexPath) as! MapTableViewCell
            cell.product = product!
            return cell
        case .expirationDate:
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ExpirationDateCellIdentifier, for: indexPath)
            if let date = product!.expirationDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                cell.textLabel!.text = formatter.string(from: date as Date)
            } else {
                cell.textLabel!.text = Constants.NoExpirationDate
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let (_, _, header) = tableStructureForProduct[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath as NSIndexPath).section {
        case 7:
            return 300
        default:
            return 88
        }
    }
    
    // MARK: TagListViewDelegate
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        /// shoudl open the corresponding url in safari
        if (product?.links != nil) && (product?.links!.count > 0) {
            var urlToOpen = product!.links![0]
            if (urlToOpen.scheme!.length() == 0)
            {
                let text = "http://" + urlToOpen.absoluteString;
                urlToOpen  = URL.init(string:text)!;
            }
            print("Tag pressed: \(title), \(urlToOpen)")
            if UIApplication.shared.canOpenURL(urlToOpen as URL) {
                UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil)
            }
        }
        tagView.isSelected = !tagView.isSelected
    }
    

    // MARK: - Notification handler
    
    func reloadMapSection(_ notification: Notification) {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 7)], with: UITableViewRowAnimation.fade)
    }

    func refreshProduct() {
        tableView.reloadData()
    }

    func removeProduct() {
        product = nil
        tableView.reloadData()
    }

    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        // self.tableView.estimatedRowHeight = 80.0
        // tableView.translatesAutoresizingMaskIntoConstraints = false;
        // refreshProduct()
        
        title = Constants.ViewControllerTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector:#selector(SupplyChainTableViewController.refreshProduct), name: .ProductUpdated, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(SupplyChainTableViewController.removeProduct), name: .HistoryHasBeenDeleted, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(SupplyChainTableViewController.reloadMapSection), name: .CoordinateHasBeenSet, object:nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        OFFProducts.manager.flushImages()
    }

}
