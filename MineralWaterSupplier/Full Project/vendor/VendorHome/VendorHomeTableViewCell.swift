//
//  VendorHomeTableViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 12/03/2023.
//

import UIKit

class VendorHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var SizeTextField: UILabel!
    @IBOutlet weak var QtyTextField: UILabel!
    @IBOutlet weak var PriceField: UILabel!
    @IBOutlet weak var imageViewPic:UIImageView!
    @IBOutlet weak var DeleteButton:UIButton!
    @IBOutlet weak var DetailButton:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
