//
//  ViewController.swift
//  PaymentApp
//
//  Created by Consultor on 1/2/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {
    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let moneyAnimation = LOTAnimationView(name: "money")
        animationView.addSubview(moneyAnimation)
        moneyAnimation.addConstraintsToCenter()
        moneyAnimation.contentMode = .scaleAspectFit
        moneyAnimation.loopAnimation = true
        moneyAnimation.autoReverseAnimation = true
        moneyAnimation.play()
    }


}

extension UIView {
    func addConstraintsToCenter(scale: CGFloat = 1){
        self.translatesAutoresizingMaskIntoConstraints = false;
        let centerX = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.width, multiplier: scale, constant: 0)
        let height = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.height, multiplier: scale, constant: 0)
        self.superview?.addConstraints([centerX, centerY, width, height])
    }
}

