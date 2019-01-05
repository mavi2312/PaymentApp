//
//  ViewController.swift
//  PaymentApp
//
//  Created by Consultor on 1/2/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit
import Lottie

protocol InfoToBaseViewControllerDelegate{
    func setAmount(_ amount : String?)
    func setPaymentMethod(_ paymentMethod: PaymentMethod?)
    func setCardIssuer(_ cardIssuer: CardIssuer?)
    func setInstallments(_ installment: Installment?)
    func getPaymentMethodId() -> String?
    func getCardIssuerId() -> String?
    func getAmount() -> String?
    func getRecommendedMessage() -> String?
}

class BaseViewController: UIViewController {
    @IBOutlet weak var animationView: UIView!
    
    var amount: String? = ""
    var selectedPaymentMethod: PaymentMethod? = nil
    var selectedCardIssuer: CardIssuer? = nil
    var selectedInstallment: Installment? = nil
    
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier ?? "")
        if segue.identifier == "baseSegue" {
            if let navigationController = segue.destination as? UINavigationController {
                if let amountViewController = navigationController.rootViewController as? AmountViewController{
                    amountViewController.delegate = self
                }
            }
        }
        
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

extension BaseViewController: InfoToBaseViewControllerDelegate{
    func getRecommendedMessage() -> String? {
        return self.selectedInstallment?.recommended_message
    }
    
    func getCardIssuerId() -> String? {
        return self.selectedCardIssuer?.id
    }
    
    func getAmount() -> String? {
        return self.amount
    }
    
    func getPaymentMethodId() -> String? {
        return self.selectedPaymentMethod?.id
    }
    
    func setAmount(_ amount: String?) {
        self.amount = amount
    }
    
    func setPaymentMethod(_ paymentMethod: PaymentMethod?) {
        self.selectedPaymentMethod = paymentMethod
    }
    
    func setCardIssuer(_ cardIssuer: CardIssuer?) {
        self.selectedCardIssuer = cardIssuer
    }
    
    func setInstallments(_ installment: Installment?) {
        self.selectedInstallment = installment
    }
    

}
extension UINavigationController {
    var rootViewController : UIViewController? {
        return viewControllers.first
    }
}
