//
//  AmountViewController.swift
//  PaymentApp
//
//  Created by Consultor on 1/2/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController {

    var delegate: InfoToBaseViewControllerDelegate? = nil
    
    @IBOutlet weak var amountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToPaymentMethod" {
            if let paymentMethodViewController = segue.destination as? PaymentMethodViewController{
                delegate?.setAmount(amountTextField.text)
                paymentMethodViewController.delegate = self.delegate
            }
        }
    }
    
    
    @IBAction func finishPayment(segue:UIStoryboardSegue){
        print("Amount: \(delegate?.amount ?? "error"), PaymentMethod: \(delegate?.selectedPaymentMethod?.name ?? "error"), CardIssuer: \(delegate?.selectedCardIssuer?.name ?? "error"), Installments: \(delegate?.selectedInstallment?.recommended_message ?? "error")")
        let finalAlertView = FinalAlertView(delegate?.amount, delegate?.selectedPaymentMethod, delegate?.selectedCardIssuer, delegate?.selectedInstallment)
        finalAlertView.show(animated: true)
    }
    
    @IBAction func validateAmount(_ sender: Any) {
        if amountTextField.text?.isEmpty ?? true{
            let emptyError: ErrorTypes = .emptyAmountError
            print(emptyError.message)
            let errorDialog = ErrorAlertView(emptyError)
            //errorDialog.delegate = self
            errorDialog.show(animated: true)
        } else if !(amountTextField.text?.isNumeric ?? false) {
            let invalidError: ErrorTypes = .invalidAmountError
            print(invalidError.message)
            let errorDialog = ErrorAlertView(invalidError)
            //errorDialog.delegate = self
            errorDialog.show(animated: true)
        } else {
            performSegue(withIdentifier: "goToPaymentMethod", sender: nil)
        }
    }

}

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
