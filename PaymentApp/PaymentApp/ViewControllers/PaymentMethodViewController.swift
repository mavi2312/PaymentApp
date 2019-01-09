//
//  PaymentMethodViewController.swift
//  PaymentApp
//
//  Created by Consultor on 1/2/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit

class PaymentMethodViewController: UIViewController {

    var delegate: InfoToBaseViewControllerDelegate? = nil
    
    var paymentMethods: [PaymentMethod]? = []
    
    let cellIdentifier = "PaymentMethodCollectionViewCell"
    
    var selectedPaymentMethod: PaymentMethod? = nil
    
    @IBOutlet weak var paymentMethodsCollectionView: UICollectionView!
    
    var loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkAPIManager()
        let paymentMethodRequestModel = PaymentMethodRequestModel(public_key: networkManager.publicKey)
        if let params = try? paymentMethodRequestModel.asDictionary(){
            loadingView.show(animated: true)
            networkManager.request(urlString: .paymentMethods, params: params){
                (response: [PaymentMethod]?, error: ErrorTypes?) in
                self.loadingView.dismiss(animated: true)
                if let networkError = error {
                    print(networkError.message)
                    //Error Dialog
                    let errorDialog = ErrorAlertView(networkError)
                    errorDialog.delegate = self
                    errorDialog.show(animated: true)
                } else {
                    //print("response?[0].name: \(response?[0].name ?? "")")
                    if (response?.count ?? 0) > 0 {
                        self.paymentMethods = response
                        self.paymentMethodsCollectionView.reloadData()
                    } else {
                        let emptyError: ErrorTypes = .emptyListError
                        print(emptyError.message)
                        let errorDialog = ErrorAlertView(emptyError)
                        errorDialog.delegate = self
                        errorDialog.show(animated: true)
                        //Error Dialog
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
        if segue.identifier == "goToCardIssuer" {
            delegate?.setPaymentMethod(selectedPaymentMethod)
            if let cardIssuersViewController = segue.destination as? CardIssuersViewController{
                cardIssuersViewController.delegate = self.delegate
            }
        }
    }
    
    @IBAction func validateSelectedPaymentMethod(_ sender: Any) {
        if selectedPaymentMethod != nil {
            performSegue(withIdentifier: "goToCardIssuer", sender: nil)
        } else {
            let invalidError: ErrorTypes = .unselectedMethodError
            print(invalidError.message)
            let errorDialog = ErrorAlertView(invalidError)
            //errorDialog.delegate = self
            errorDialog.show(animated: true)
        }
    }
    
    @IBAction func goBack(_ sender: Any){
        navigationController?.popViewController(animated: true)
    }
    
}
extension PaymentMethodViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.paymentMethods?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PaymentMethodCollectionViewCell {
            cell.viewModel = PaymentMethodCollectionViewCell.ViewModel(paymentMethods?[indexPath.item])
            //cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPaymentMethod = paymentMethods?[indexPath.row]
    }
    
}
extension PaymentMethodCollectionViewCell.ViewModel{
    init(_ paymentMethod: PaymentMethod?){
        id = paymentMethod?.id ?? ""
        imagePath = paymentMethod?.secure_thumbnail ?? ""
        name = paymentMethod?.name ?? ""
        isSelected = false
    }
        
}

extension PaymentMethodViewController: ErrorActionDelegate {
    func errorAction() {
        navigationController?.popViewController(animated: true)
    }
}
