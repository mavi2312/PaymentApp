//
//  InstallmentTableViewCell.swift
//  PaymentApp
//
//  Created by Consultor on 1/6/19.
//  Copyright © 2019 Mavzapps. All rights reserved.
//

import UIKit

class InstallmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recommendedMessageLabel: UILabel!
    
    var recommendedMessage = "" {
        didSet{
            recommendedMessageLabel.text = recommendedMessage
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

