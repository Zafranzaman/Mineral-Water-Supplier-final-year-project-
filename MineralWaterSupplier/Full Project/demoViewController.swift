//
//  demoViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 15/06/2023.
//

import UIKit

class demoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var demobtn: UIButton!
    
    @IBAction func f1(_ sender: Any) {
        if demobtn.isSelected {
            demobtn.isSelected = false
        }
        else
        {
            demobtn.isSelected = true
        }
        
    }
    
}
