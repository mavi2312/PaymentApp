//
//  InstallmentsViewController.swift
//  PaymentApp
//
//  Created by Consultor on 1/2/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit

class InstallmentsViewController: UIViewController {
    
    @IBOutlet weak var installmentTableView: UITableView!{
        didSet{
            installmentTableView.rowHeight = UITableView.automaticDimension
            installmentTableView.estimatedRowHeight = 68
        }
    }
    var delegate: InfoToBaseViewControllerDelegate? = nil
    var instalmentsResponse: [Installment]? = []
    
    var selectedInstallment: Installment? = nil
    
    let cellIdentifier = "InstallmentTableViewCell"
    
    var loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installmentTableView.tableFooterView = UIView()
        let networkManager = NetworkAPIManager()
        let installmentsRequestModel = InstallmentsRequestModel(public_key: networkManager.publicKey, payment_method_id: (delegate?.selectedPaymentMethod?.id ?? ""), amount:  (delegate?.amount ?? ""), issuer_id: (delegate?.selectedCardIssuer?.id ?? ""))
        if let params = try? installmentsRequestModel.asDictionary(){
            loadingView.show(animated: true)
            networkManager.request(urlString: .installments, params: params){
                (response: [InstallmentsResponse]?, error: ErrorTypes?) in
                self.loadingView.dismiss(animated: true)
                if let networkError = error {
                    print(networkError.message)
                    //Error Dialog
                    let errorDialog = ErrorAlertView(networkError)
                    errorDialog.delegate = self
                    errorDialog.show(animated: true)
                } else {
                    if (response?.count ?? 0) > 0 {
                        self.instalmentsResponse = response?[0].payer_costs
                        self.installmentTableView.reloadData()
                    } else {
                        let emptyError: ErrorTypes = .emptyListError
                        print(emptyError.message)
                        let errorDialog = ErrorAlertView(emptyError)
                        errorDialog.delegate = self
                        errorDialog.show(animated: true)
                    }
                    
                }
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
            delegate?.setInstallments(selectedInstallment)
            
        }
    }
    
    
    @IBAction func validateSelectedInstallment(_ sender: Any) {
        if selectedInstallment != nil {
            performSegue(withIdentifier: "finishPaymentProcess", sender: nil)
        }
    }
    
    @IBAction func goBack(_ sender: Any){
        navigationController?.popViewController(animated: true)
    }
    
}

extension InstallmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instalmentsResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InstallmentTableViewCell {
            cell.recommendedMessage = instalmentsResponse?[indexPath.item].recommended_message ?? ""
            //cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedInstallment = instalmentsResponse?[indexPath.row]
    }
}

extension InstallmentsViewController: ErrorActionDelegate {
    func errorAction() {
        navigationController?.popViewController(animated: true)
    }
    
}

