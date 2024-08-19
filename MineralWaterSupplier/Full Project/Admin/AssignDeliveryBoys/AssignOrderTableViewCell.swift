//
//  AssignOrderTableViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 26/05/2023.
//

import UIKit

class AssignOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var OrderNo: UILabel!
    @IBOutlet weak var AssignOrder: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
