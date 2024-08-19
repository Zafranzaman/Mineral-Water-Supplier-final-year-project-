//
//  DeliveryboyhomeTableViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 10/06/2023.
//

import UIKit

class DeliveryboyhomeTableViewCell: UITableViewCell {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Contact: UILabel!
    @IBOutlet weak var Oid: UILabel!
    @IBOutlet weak var TotalPrice: UILabel!
    @IBOutlet weak var StartRide: UIButton!
    @IBOutlet weak var package: UILabel!
    @IBOutlet weak var sunday: UILabel!
    @IBOutlet weak var monday: UILabel!
    @IBOutlet weak var tuesday: UILabel!
    @IBOutlet weak var wednesday: UILabel!
    @IBOutlet weak var thursday: UILabel!
    @IBOutlet weak var friday: UILabel!
    @IBOutlet weak var saturday: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
