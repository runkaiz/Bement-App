//
//  StatisticsViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 11/29/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var CreateNew: UIButton!
    @IBOutlet weak var titleLabel: ShiftMaskableLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools.beautifulButton(CreateNew)
        CreateNew.applyGradient(colours: [#colorLiteral(red: 1, green: 0, blue: 0.8563808203, alpha: 1), #colorLiteral(red: 0, green: 0.8750895858, blue: 1, alpha: 1)])
        titleLabel.textLabel.font = UIFont.boldSystemFont(ofSize: 35)
        titleLabel.textLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textLabel.textAlignment = .center
        titleLabel.setColors([#colorLiteral(red: 1, green: 0, blue: 0.8563808203, alpha: 1), #colorLiteral(red: 0, green: 0.8750895858, blue: 1, alpha: 1)])
        titleLabel.setText("Statistics")
        titleLabel.start(shiftPoint: .left)
        titleLabel.end(shiftPoint: .right)
        titleLabel.animationDuration(3.0)
        titleLabel.maskToText = true
        titleLabel.startTimedAnimation()
    }
}
