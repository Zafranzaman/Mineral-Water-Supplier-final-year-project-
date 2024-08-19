//
//  AdminHomeViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 18/01/2023.
//

import UIKit

class AdminHomeViewController: UIViewController,UIViewControllerTransitioningDelegate  {
    
    @IBOutlet private weak var menuImageView:UIImageView!{
        didSet{
            menuImageView.addTapGesture {
                self.presentMenu()
            }
        }
    }
    let backgroundimageview = UIImageView()
    func setBackground() {
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Agency")
        view.sendSubviewToBack(backgroundimageview)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    @IBAction func AllOrders(_ sender:UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "neworderViewController") as! UINavigationController
      //  self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    @IBAction func Addwarehoouse(_ sender:UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AddwarehouseViewController") as! AddwarehouseViewController
           // self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    func presentMenu() {
        let menuViewController = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        menuViewController.delegate = self
        present(menuViewController, animated: true, completion: nil)
    }
 
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator(isPresenting: false)
    }
    
}

extension AdminHomeViewController:MenuViewControllerDelegate{
    func didPressHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            RedirectHelper.shared.determineRoutes(storyBoard: .AdminDashboard)
        }
        print("Move whatever the home screen is")
    }
    
    func didPressProfile() {
        print("go to Profile screen")
    }
    
    func didPressLogout() {
        //remove session form userdefault.
        UserSession.shared.logout()
        print("Logout, remove session from user default and go to login screen or SplashScreen")
    }
    
    
}
