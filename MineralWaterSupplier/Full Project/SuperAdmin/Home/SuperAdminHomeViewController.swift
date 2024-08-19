//
//  SuperAdminHomeViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 24/05/2023.
//

import UIKit

class SuperAdminHomeViewController: UIViewController {
    @IBOutlet weak var lbname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        //lbname.text = UserSession.shared.user?.name!
    }
    @IBAction func Logout(_ sender: Any) {
        UserSession.shared.logout()
    }
        let backgroundimageview = UIImageView()
        func setBackground() {
            view.addSubview(backgroundimageview)
            backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
            backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            backgroundimageview.image = UIImage(named: "super")
            view.sendSubviewToBack(backgroundimageview)
    
        }
   
    @IBAction func Ranking(_ sender:UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AdminRankingViewController") as! AdminRankingViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    @IBAction func vendorrequest(_ sender:UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "VendorRequestViewController") as! VendorRequestViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    @IBAction func AgencyRequest(_ sender:UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AgencyRequestViewController") as! AgencyRequestViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
}
