//
//  agencyOrderTableViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 24/05/2023.
//

import UIKit

class agencyOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var OrderNo: UILabel!
    @IBOutlet weak var TotalPrice: UILabel!
    @IBOutlet weak var Contact: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var DetailButton:UIButton!
   // @IBOutlet weak var RejectButton:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}