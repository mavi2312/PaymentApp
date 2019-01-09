//
//  LoadingView.swift
//  PaymentApp
//
//  Created by Consultor on 1/8/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView, Modal{
    
    var backgroundView = UIView()
    
    var dialogView = UIView()
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var animationContainerView: UIView!
    
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        loadAlertView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func loadAlertView(){
        print(bounds)
        backgroundView.frame = bounds
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        //backgroundView.alpha = 1
        
        addSubview(backgroundView)
        addConstraintsToBackground()
        
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        dialogView = contentView
        addSubview(dialogView)
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width - 30, height: contentView.frame.height)
        dialogView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addConstraintsToDialog()
        
        let animationView = LOTAnimationView(name: "jumping_coins")
        animationContainerView.addSubview(animationView)
        animationView.addConstraintsToCenter()
        animationView.contentMode = .scaleAspectFit
        animationView.loopAnimation = true
        animationView.autoReverseAnimation = true
        animationView.play()
        
        
        
    }
    
    func addConstraintsToBackground(){
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        let centerX = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        addConstraints([centerX, centerY, width, height])
    }
    
    func addConstraintsToDialog(){
        dialogView.translatesAutoresizingMaskIntoConstraints = false;
        
        let centerX = NSLayoutConstraint(item: dialogView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: dialogView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: dialogView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: dialogView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        addConstraints([centerX, centerY, width, height])
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
