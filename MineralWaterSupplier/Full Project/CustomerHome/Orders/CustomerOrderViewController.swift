//
//  CustomerOrderViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 20/01/2023.
//

import UIKit

class CustomerOrderViewController: UIViewController {
    let backgroundimageview = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
    }
    
   
    
}
extension CustomerOrderViewController {
    func setBackground(){
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Customertheme")
        view.sendSubviewToBack(backgroundimageview)
        
    }
}
