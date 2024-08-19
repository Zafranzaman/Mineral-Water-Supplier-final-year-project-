//
//  updateProductsViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 07/05/2023.
//

import UIKit

class updateProductsViewController: UIViewController {
    let backgroundimageview = UIImageView()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var SizeTextField: UITextField!
    @IBOutlet weak var QTYTextField: UITextField!
    @IBOutlet weak var PriceField: UITextField!
    @IBOutlet weak var imageViewPic:UIImageView!
    var Allproducts = [vendorProducts]()
    var indexpath:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
      setBackground()
        setBackground()
        var productdetail = Allproducts[indexpath]
        nameTextField.text = productdetail.productname!
        SizeTextField.text = productdetail.size!
        QTYTextField.text = "\(productdetail.qty!)"
        PriceField.text = "\(productdetail.price!)"
        imageViewPic.image = Utility.GetImageFromURL(name: productdetail.image!)
        
    }
    @IBAction private func UpdateAction(_ sender: UIButton){
        RedirectHelper.shared.determineRoutes(storyBoard: .VendorDashboard)
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
