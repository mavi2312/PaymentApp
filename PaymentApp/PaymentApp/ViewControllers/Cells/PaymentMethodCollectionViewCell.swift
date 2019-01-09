//
//  PaymentMethodCollectionViewCell.swift
//  PaymentApp
//
//  Created by Consultor on 1/5/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit
import AlamofireImage

class PaymentMethodCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var paymentMethodImageView: UIImageView!
    
    @IBOutlet weak var paymentMethodNameLabel: UILabel!
    var viewModel = ViewModel(){
        didSet{
            paymentMethodNameLabel.text = viewModel.name
            if let url = URL(string: "\(viewModel.imagePath)" ){
                paymentMethodImageView.af_setImage(withURL: url)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                backgroundColor = UIColor(white: 0.8, alpha: 0.7)
            } else {
                backgroundColor = .white
            }
        }
    }
}
extension PaymentMethodCollectionViewCell {
    struct ViewModel{
        var name = ""
        var imagePath = ""
        var isSelected = false
        var id = ""
    }
}
