//
//  SpecailOfferTableViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 06/05/2023.
//

import UIKit

class SpecailOfferTableViewCell: UITableViewCell {
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var AddToCart: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
