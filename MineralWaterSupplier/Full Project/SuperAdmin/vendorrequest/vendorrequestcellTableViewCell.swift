//
//  vendorrequestcellTableViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 19/01/2023.
//

import UIKit

class vendorrequestcellTableViewCell: UITableViewCell {
    @IBOutlet weak var lbno: UILabel!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet var AcceptButton:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
}
