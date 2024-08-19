//
//  ShowScheduleTableViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 28/05/2023.
//

import UIKit

class ShowScheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var oid: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var package: UILabel!
    @IBOutlet weak var Rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
