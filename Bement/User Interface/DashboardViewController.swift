//
//  DashboardViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 11/26/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var theLookAhead: UIButton!
    @IBOutlet weak var alerts: UIButton!
    @IBOutlet weak var progressReport: UIButton!
    @IBOutlet weak var imports: UIButton!
    
    let presentSectionViewController = PresentSectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shadowMaker(button: theLookAhead)
        shadowMaker(button: alerts)
        shadowMaker(button: progressReport)
        shadowMaker(button: imports)
    }
    
    @IBAction func done(_ segue: UIStoryboardSegue) {
        //print("Popping back to this view controller!")
        // reset UI elements etc here
    }
    
    func shadowMaker(button:UIButton) {
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = false
        
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 25
        button.layer.shadowOffset = CGSize(width: 0, height: 12.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lookAhead" {
            let destination = segue.destination as! LookAheadViewController
            
            let cellFrame = view.convert(theLookAhead.frame, from: theLookAhead.superview)
            
            presentSectionViewController.cellFrame = cellFrame
            presentSectionViewController.cellTransform = animateCell(cellFrame: cellFrame)
            
            destination.transitioningDelegate = self
        }
    }
    
    func animateCell(cellFrame: CGRect) -> CATransform3D {
        let angleFromX = Double((-cellFrame.origin.x) / 10)
        let angle = CGFloat((angleFromX * Double.pi) / 180.0)
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)
        
        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        let scaleMax: CGFloat = 1.0
        let scaleMin: CGFloat = 0.6
        if scaleFromX > scaleMax {
            scaleFromX = scaleMax
        }
        if scaleFromX < scaleMin {
            scaleFromX = scaleMin
        }
        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)
        
        return CATransform3DConcat(rotation, scale)
    }
}

extension DashboardViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return presentSectionViewController
    }
}
