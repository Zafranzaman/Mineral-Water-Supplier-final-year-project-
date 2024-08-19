//
//  totalorderadminTableViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 19/01/2023.
//

import UIKit

class totalorderadminTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBOutlet weak var OrderNo: UILabel!
    @IBOutlet weak var TotalPrice: UILabel!
//    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Contact: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var detailButton:UIButton!
}
