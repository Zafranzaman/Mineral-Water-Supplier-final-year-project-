//
//  RedirectScreen.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 09/03/2023.
//

import Foundation


class UserSession{
    
    static let shared = UserSession()
    private let key = "userData"
    private init(){
        //here we need to fetch the user form userdefault
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else {return}
        let userData = try? JSONDecoder().decode(LoginModel.self, from: data)
        self.user = userData
    }
    
    var user:LoginModel?{
        didSet{
            //here we wil save the user in UserDefault
            
            guard let user = self.user else {
                //delete the user form UserDefault
                UserDefaults.standard.removeObject(forKey: key)
                return
                
            }
           
            //Save/update the user in UserDefault
            
            //- to save in UserDefault we need to encode the data
            let data = try? JSONEncoder().encode(user)
            //now save the Data  in UserDefault
            UserDefaults.standard.set(data, forKey: key)
           
        }
    }
   
    
    func redirect(){
        if let user = self.user{
            //this means user is already logged in and we can redirect to appropriate screen.
            if user.userType == .Vendor{
                RedirectHelper.shared.determineRoutes(storyBoard: .VendorDashboard)
            }else if user.userType == .Agency {
                RedirectHelper.shared.determineRoutes(storyBoard: .AdminDashboard)
            }
            else if user.userType == .Customer {
                RedirectHelper.shared.determineRoutes(storyBoard: .Customer)
            }
            else if user.userType == .superAdmin {
                RedirectHelper.shared.determineRoutes(storyBoard: .superAdmin)
            }
            else if user.userType == .DeliveryBoy {
                RedirectHelper.shared.determineRoutes(storyBoard: .DeliveryBoy)
            }
            //reset will come here
        }else {
            //this means user is not login, we need to redirect to  `Auth/splash`
            RedirectHelper.shared.determineRoutes(storyBoard: .Auth)
            
        }
    }
    
    func logout(){
        user = nil
       // RedirectHelper.shared.determineRoutes(storyBoard: .Auth)
        redirect()
    }
}
