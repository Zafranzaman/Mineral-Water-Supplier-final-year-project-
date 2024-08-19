//
//  CustomerHomeCollectionViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 27/03/2023.
//

import UIKit
import Cosmos
class CustomerHomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var AddToCart: UIButton!
    @IBOutlet weak var Rating: UILabel!
    
}
