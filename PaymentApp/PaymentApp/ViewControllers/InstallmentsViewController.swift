//
//  InstallmentsViewController.swift
//  PaymentApp
//
//  Created by Consultor on 1/2/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit

class InstallmentsViewController: UIViewController {

    var delegate: InfoToBaseViewControllerDelegate? = nil
    var instalmentsResponse: [InstallmentsResponse]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let networkManager = NetworkAPIManager()
        let installmentsRequestModel = InstallmentsRequestModel(public_key: networkManager.publicKey, payment_method_id: (delegate?.getPaymentMethodId() ?? ""), amount:  (delegate?.getAmount() ?? ""), issuer_id: (delegate?.getCardIssuerId() ?? ""))
        if let params = try? installmentsRequestModel.asDictionary(){
            networkManager.request(urlString: .installments, params: params){
                (response: [InstallmentsResponse]?, error: ErrorTypes?) in
                print("response?[0].name: \(response?[0].payer_costs?[0].recommended_message ?? "")")
                self.instalmentsResponse = response
            }
        }
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "finishPaymentProcess" {
            delegate?.setInstallments(instalmentsResponse?[0].payer_costs?[0])
            /*if let installmentsViewController = segue.destination as? InstallmentsViewController{
                installmentsViewController.delegate = self.delegate
            }*/
        }
    }
    

}
