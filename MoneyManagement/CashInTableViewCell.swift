//
//  CashInTableViewCell.swift
//  MoneyManagement
//
//  Created by Palpandian,Sruthi on 4/1/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit

class CashInTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var transDesc: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
