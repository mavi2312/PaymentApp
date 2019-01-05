//
//  BankViewController.swift
//  PaymentApp
//
//  Created by Consultor on 1/2/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit

class CardIssuersViewController: UIViewController {

    var cardIssuers : [CardIssuer]? = []
    var delegate: InfoToBaseViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let networkManager = NetworkAPIManager()
        let cardIssuersRequestModel = CardIssuerRequestModel(public_key: networkManager.publicKey, payment_method_id: (delegate?.getPaymentMethodId() ?? ""))
        if let params = try? cardIssuersRequestModel.asDictionary(){
            networkManager.request(urlString: .cardIssuers, params: params){
                (response: [CardIssuer]?, error: ErrorTypes?) in
                print("response?[0].name: \(response?[0].name ?? "")")
                self.cardIssuers = response
            }
        }
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToInstallments" {
            delegate?.setCardIssuer(cardIssuers?[0])
            if let installmentsViewController = segue.destination as? InstallmentsViewController{
                installmentsViewController.delegate = self.delegate
            }
        }
    }
    

}
