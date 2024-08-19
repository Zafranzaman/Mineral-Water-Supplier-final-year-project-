//
//  VendorProductDetailsViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 19/03/2023.
//

import UIKit

class VendorProductDetailsViewController: UIViewController {
    let backgroundimageview = UIImageView()
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var SizeTextField: UILabel!
    @IBOutlet weak var QTYTextField: UILabel!
    @IBOutlet weak var PriceField: UILabel!
    @IBOutlet weak var imageViewPic:UIImageView!
    var Allproducts = [vendorProducts]()
    var indexpath:Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        var productdetail = Allproducts[indexpath]
        nameTextField.text = productdetail.productname!
        SizeTextField.text = productdetail.size!
        QTYTextField.text = "\(productdetail.qty!)"
        PriceField.text = "\(productdetail.price!)"
        imageViewPic.image = Utility.GetImageFromURL(name: productdetail.image!)
    }
    
    @IBAction private func UpdateAction(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "updateProductsViewController") as! updateProductsViewController
       
        vc.Allproducts = Allproducts
        vc.indexpath = indexpath
     self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
        func setBackground() {
            view.addSubview(backgroundimageview)
            backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
            backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            backgroundimageview.image = UIImage(named: "Darktheme")
            view.sendSubviewToBack(backgroundimageview)
    
        }
  

}
