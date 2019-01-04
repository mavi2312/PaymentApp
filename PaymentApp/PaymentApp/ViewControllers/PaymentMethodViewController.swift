//
//  PaymentMethodViewController.swift
//  PaymentApp
//
//  Created by Consultor on 1/2/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit

class PaymentMethodViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkAPIManager()
        let paymentMethodRequestModel = PaymentMethodRequestModel(public_key: networkManager.publicKey)
        if let params = try? paymentMethodRequestModel.asDictionary(){
            networkManager.request(urlString: .paymentMethods, params: params){
                (response: [PaymentMethod]?, error: ErrorTypes?) in
                print("response?[0].name: \(response?[0].name ?? "")")
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
