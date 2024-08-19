//
//  CustomerCartTableViewCell.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 04/04/2023.
//

import UIKit

protocol CustomerCartTableViewCellDelegate{
    func didDeleteFormCart(cartItem:CustomerCart)
    func didIncreaseQuantity(cartItem:CustomerCart)
    func didDecreaseQuantity(cartItem:CustomerCart)
}

class CustomerCartTableViewCell: UITableViewCell {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var qty: UITextField!
    
    @IBOutlet weak var PriceField: UILabel!
    @IBOutlet weak var imageViewPic:UIImageView!
    @IBOutlet weak var DeleteButton:UIButton!
    @IBOutlet weak var ADDButton:UIButton!
    @IBOutlet weak var SubractButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
         
    }
    
    var delegate:CustomerCartTableViewCellDelegate?
    
    var cartproduct: CustomerCart?{
        didSet{
            self.Name.text = cartproduct?.productname!
            self.PriceField.text = "RS \(cartproduct?.price ?? 0.0)"
            self.qty.text = "\(cartproduct?.quantity ?? 0)"
            let img = cartproduct?.image ?? ""
            self.imageViewPic.image = Utility.GetImageFromURL(name: cartproduct?.image ?? "")
        }
    }
    
    
    @IBAction private func deleteAction(_ sender: UIButton){
        guard let product = self.cartproduct else {
            assertionFailure("go to `CartDisplayViewController` and in tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) and assign `cartproduct` ")
            return
        }
        self.delegate?.didDeleteFormCart(cartItem: product)
    }
    
    @IBAction private func increaseQuantityAction(_ sender: UIButton){
        guard let product = self.cartproduct else {
            assertionFailure("go to `CartDisplayViewController` and in tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) and assign `cartproduct` ")
            return
        }
        self.delegate?.didIncreaseQuantity(cartItem: product)
    }
    
    @IBAction private func decreaseQuantityAction(_ sender: UIButton){
        guard let product = self.cartproduct else {
            assertionFailure("go to `CartDisplayViewController` and in tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) and assign `cartproduct` ")
            return
        }
        self.delegate?.didDecreaseQuantity(cartItem: product)
    }
}
