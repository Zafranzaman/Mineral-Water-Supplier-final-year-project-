//
//  VendorMenuViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 27/05/2023.
//

import UIKit
protocol VendorMenuViewControllerDelegate{
    func didPressHome()
    func didPressProfile()
    func didPressProductRequest()
    func didPressLogout()
}
class VendorMenuViewController: UIViewController {
    var delegate:VendorMenuViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func closeAction(_ sender: UIButton){
        self.dismiss(animated: true)
    }

    @IBAction private func homeAction(_ sender: UIButton){
        self.delegate?.didPressHome()
        self.dismiss(animated: true)
    }
    
    @IBAction private func profileAction(_ sender: UIButton){
        self.delegate?.didPressProfile()
        self.dismiss(animated: true)
    }
    @IBAction private func didPressProductRequest(_ sender: UIButton){
        self.delegate?.didPressProductRequest()
        self.dismiss(animated: true)
    }
   
    @IBAction private func logoutAction(_ sender: UIButton){
        self.delegate?.didPressLogout()
        self.dismiss(animated: true)
        //UserSession.shared.logout()
    }

}
