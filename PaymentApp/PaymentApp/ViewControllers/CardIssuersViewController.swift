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
    @IBOutlet weak var cardIssuersCollectionView: UICollectionView!
    
    var selectedCardIssuer: CardIssuer? = nil
    
    let cellIdentifier = "CardIssuersCollectionViewCell"
    
    var loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let networkManager = NetworkAPIManager()
        let cardIssuersRequestModel = CardIssuerRequestModel(public_key: networkManager.publicKey, payment_method_id: (delegate?.selectedPaymentMethod?.id ?? ""))
        if let params = try? cardIssuersRequestModel.asDictionary(){
            loadingView.show(animated: true)
            networkManager.request(urlString: .cardIssuers, params: params){
                (response: [CardIssuer]?, error: ErrorTypes?) in
                self.loadingView.dismiss(animated: true)
                if let networkError = error {
                    print(networkError.message)
                    //Error Dialog
                    let errorDialog = ErrorAlertView(networkError)
                    errorDialog.delegate = self
                    errorDialog.show(animated: true)
                } else {
                    if (response?.count ?? 0) > 0 {
                        self.cardIssuers = response
                        self.cardIssuersCollectionView.reloadData()
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
        if segue.identifier == "goToInstallments" {
            delegate?.setCardIssuer(selectedCardIssuer)
            if let installmentsViewController = segue.destination as? InstallmentsViewController{
                installmentsViewController.delegate = self.delegate
            }
        }
    }
    
    @IBAction func validateSelectedCardIssuer(_ sender: Any) {
        if selectedCardIssuer != nil {
            performSegue(withIdentifier: "goToInstallments", sender: nil)
        } else {
            let invalidError: ErrorTypes = .unselectedIssuerError
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
extension CardIssuersViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardIssuers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PaymentMethodCollectionViewCell {
            cell.viewModel = PaymentMethodCollectionViewCell.ViewModel(cardIssuers?[indexPath.item])
            //cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCardIssuer = cardIssuers?[indexPath.row]
    }
    
}
extension PaymentMethodCollectionViewCell.ViewModel{
    init(_ cardIssuer: CardIssuer?){
        id = cardIssuer?.id ?? ""
        imagePath = cardIssuer?.secure_thumbnail ?? ""
        name = cardIssuer?.name ?? ""
        isSelected = false
    }
    
}
extension CardIssuersViewController: ErrorActionDelegate {
    func errorAction() {
        navigationController?.popViewController(animated: true)
    }
    
}
