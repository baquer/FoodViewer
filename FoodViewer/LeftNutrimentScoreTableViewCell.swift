//
//  LeftNutrimentScoreTableViewCell.swift
//  FoodViewer
//
//  Created by arnaud on 04/05/17.
//  Copyright © 2017 Hovering Above. All rights reserved.
//

import UIKit

class LeftNutrimentScoreTableViewCell: UITableViewCell {
    
    enum NutritionScoreType {
        case good
        case bad
    }
        
    var nutrimentScore: (String, Int, Int, Int, NutritionScoreType)? = nil {
        didSet {
            guard nutrimentScore != nil else { return }
            nutrimentLabel.text = nutrimentScore!.0
                
            nutrimentScoreBarGaugeView.maxLimit = Float(nutrimentScore!.2)
            nutrimentScoreBarGaugeView.numBars = nutrimentScore!.2
            nutrimentScoreBarGaugeView.value = Float(nutrimentScore!.1)
            nutrimentValue.text = "\(nutrimentScore!.1)"
            nutrimentScoreBarGaugeView.dangerThreshold = nutrimentScoreBarGaugeView.maxLimit
            nutrimentScoreBarGaugeView.warnThreshold = nutrimentScoreBarGaugeView.maxLimit
                
            switch nutrimentScore!.4 {
            case .bad:
                nutrimentScoreBarGaugeView.reverse = false
                nutrimentScoreBarGaugeView.normalBarColor = .red
            case .good:
                nutrimentScoreBarGaugeView.reverse = true
                nutrimentScoreBarGaugeView.normalBarColor = .green
            }
        }
    }
    @IBOutlet weak var nutrimentValue: UILabel!
        
    @IBOutlet weak var nutrimentScoreBarGaugeView: BarGaugeView! {
        didSet {
            nutrimentScoreBarGaugeView.litEffect = false
        }
    }
        
    @IBOutlet weak var nutrimentLabel: UILabel!
        
}
