//
//  LoginViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran Zaman on 10/01/2023.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    var customerData = [LoginModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func loginAction(_ sender: UIButton){
        self.login()
        }
    
    func login(){
        guard let Email = self.txtEmail.text, Email != "" else {
            Utility.alertMessage(title: "Error", message: "Enter Email")
            return
        }
        guard let Password = self.txtpassword.text, Password != "" else {
            Utility.alertMessage(title: "Error", message: "Enter Password")
            return
        }
        let endpoint = "User/Login"
        let params : [String:Any] = [
            "email":Email,
            "password":Password
        ]
        NetworkManager.shared.request(endpoint, decoder: LoginModel.self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                print(data)
               // RedirectHelper.shared.determineRoutes(storyBoard: .AdminDashboard)
                
                //save data in user session.
                UserSession.shared.user = data
                UserSession.shared.redirect()
//                if data.userType == .Admin{
//                    RedirectHelper.shared.determineRoutes(storyBoard: .AdminDashboard)
//                }else if data.userType == .Vendor{
//                    RedirectHelper.shared.determineRoutes(storyBoard: .VendorDashboard)
//                }
                
            case .failure(let error):
                print(error)
                //show alert message
                Utility.showAlertWithOkAndCancel(title: "Error !! Email or Password Incorrect!")
                
            }
        }
    }
}
