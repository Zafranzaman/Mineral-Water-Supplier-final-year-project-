//
//  SplashViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 11/01/2023.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet private weak var titleView:UIView!{
        didSet{
            let width = UIScreen.main.bounds.width / 4
            titleView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: width)
        }
    }
    @IBOutlet private weak var logoImageView:UIImageView!{
        didSet{
            logoImageView.cornerRadius = logoImageView.frame.width / 2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        user = nil
//        Redirector()
        
    }
    

    @IBAction private func getStartedAction(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
    // self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
//        RedirectHelper.shared.determineRoutes(storyBoard: .Signup)
        
    }

}
