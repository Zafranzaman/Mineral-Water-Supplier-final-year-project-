//
//  RedirectHelper.swift
//  MineralWaterSupplier
//
//  Created by Zafran Zaman on 14/02/2023.
//

import UIKit


final class RedirectHelper {
    
    enum Stoyboard : String {
        case Auth
        case AdminDashboard
        case VendorDashboard
        case DeliveryBoy
        case Customer
        case superAdmin
    }
 
    var window : UIWindow!
    
    private static let _shared = RedirectHelper()
    static var shared : RedirectHelper {
        return _shared
    }
    
    private init() {
        createWindow()
    }
    
    private func createWindow(){
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                self.window = sceneDelegate.window!
            }
            
            // iOS12 or earlier
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            guard let temp = appDelegate.window else {return}
            self.window = temp
        }
    }
    
    func determineRoutes (storyBoard: Stoyboard) {
        // User session manage here if needed
        if self.window == nil {
            self.createWindow()
        }
        
        if window == nil {
            assertionFailure()
        }
        
        let transition = CATransition()
        transition.type = .fade
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        myView.backgroundColor = .white
        window.addSubview(myView)
        
        switch storyBoard {
        case .Auth:
            setRootAuth(transition: transition, withStoryboard: .Auth)
            
        case .AdminDashboard:
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AdminHomeViewController") as! AdminHomeViewController
            self.setRootToMain(transition: transition, vc: vc)
            
        case .VendorDashboard:
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "vendortabbar") as! UITabBarController
            self.setRootToMain(transition: transition, vc: vc)
            
        case .DeliveryBoy:
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "DeliveryBoyHomeViewController") as! DeliveryBoyHomeViewController
            //fatalError("idr delivery boy ka view contolerr dana hai")
            self.setRootToMain(transition: transition, vc: vc)
            
        case .Customer:
            let mainTabbar = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "Customertabbar") as! UITabBarController
            window.set(rootViewController: mainTabbar, withTransition: transition)
            window.makeKeyAndVisible()
        case .superAdmin:
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SuperAdminHomeViewController") as! SuperAdminHomeViewController
            self.setRootToMain(transition: transition, vc: vc)
        }
    }
    

    
    func setRootAuth(transition :CATransition, withStoryboard: Stoyboard) {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthNavigationController") as! UINavigationController
        window.set(rootViewController: vc, withTransition: transition)
        window.makeKeyAndVisible()
    }
    
    func setRootToMain(transition :CATransition, vc:UIViewController) {
//        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AdminHomeViewController") as! AdminHomeViewController
        let navigation = UINavigationController(rootViewController: vc)
        navigation.setNavigationBarHidden(true, animated: true)
        window.set(rootViewController: navigation, withTransition: transition)
        window.makeKeyAndVisible()
    }
    
}

extension UIWindow {
    
    static var topWindow: UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindow.Level.normal
        window.makeKeyAndVisible()
        
        return window
    }
    
    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
        let previousViewController = rootViewController
        
        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }
        
        rootViewController = newRootViewController
        
        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        
        /// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
        /// In iOS 13 we don't want to remove the transition view as it'll create a blank screen
        /// TODO: fix leak on iOS 13
        if #available(iOS 13.0, *) {} else {
            if let transitionViewClass = NSClassFromString("UITransitionView") {
                for subview in subviews where subview.isKind(of: transitionViewClass) {
                    subview.removeFromSuperview()
                }
            }
        }
        
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}



