//
//  CashoutTableViewCell.swift
//  MoneyManagement
//
//  Created by Palpandian,Sruthi on 4/14/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit

class CashoutTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var borrowed: UILabel!

    @IBOutlet weak var repay: UILabel!
    @IBOutlet weak var from: UILabel!
}
