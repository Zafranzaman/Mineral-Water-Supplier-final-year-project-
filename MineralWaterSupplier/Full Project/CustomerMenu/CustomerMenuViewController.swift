//
//  CustomerMenuViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 20/05/2023.
//

import UIKit
protocol CustomerMenuViewControllerDelegate{
    func didPressHome()
    func didPressProfile()
    func didPressSetLocation()
    func didPressViewPrice()
    func didPressRating()
    func didPressLogout()
}
class CustomerMenuViewController: UIViewController {

    var delegate:CustomerMenuViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction private func didPressSetLocation(_ sender: UIButton){
        self.delegate?.didPressSetLocation()
        self.dismiss(animated: true)
    }
    @IBAction private func didPressViewPrice(_ sender: UIButton){
        self.delegate?.didPressViewPrice()
        self.dismiss(animated: true)
    }
    @IBAction private func didPressRating(_ sender: UIButton){
        self.delegate?.didPressRating()
        self.dismiss(animated: true)
    }
    @IBAction private func logoutAction(_ sender: UIButton){
        self.delegate?.didPressLogout()
        self.dismiss(animated: true)
        //UserSession.shared.logout()
    }
    

}
