//
//  IngredientsFullTableViewCell.swift
//  FoodViewer
//
//  Created by arnaud on 24/02/16.
//  Copyright © 2016 Hovering Above. All rights reserved.
//

import UIKit

class IngredientsFullTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    struct Constants {
        static let NoIngredientsText = NSLocalizedString("no ingredients specified", comment: "Text in a TagListView, when no ingredients are available in the product data.") 
    }
    
    var ingredients: String? = nil {
        didSet {
            if let text = ingredients {
                if !text.isEmpty {
                    ingredientsLabel.text = text
                } else {
                    ingredientsLabel.text = Constants.NoIngredientsText
                }
            }
        }
    }

}
