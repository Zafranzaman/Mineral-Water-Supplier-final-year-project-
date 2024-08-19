//
//  SignupViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran Zaman on 10/01/2023.
//

import UIKit
import DropDown
class SignupViewController: UIViewController {
    @IBOutlet weak var dropdownlabel: UILabel!
    @IBOutlet weak var dropdownview: UIView!
    @IBOutlet weak var dropdownbutton: UIButton!

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtphoneno: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    let dropdown = DropDown()
    
    var City:String?
    var Cities = ["Rawalpindi","Islamabad"]
    var Usertype:String?
    
    @IBAction func isTappedDropDown(_ sender: Any){
        dropdown.show()
    }
    
    @IBAction func didSegement(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            Usertype="Vendor"
            print("vendor")
        }
        else if sender.selectedSegmentIndex == 1{
            Usertype="Customer"
            print("Customer")
        }
        else if sender.selectedSegmentIndex == 2{
            Usertype="DeliveryBoy"
            print("DeliveryBoy")
        }
        else if sender.selectedSegmentIndex == 3{
            Usertype="Agency"
            print("Agency")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        dropdown.anchorView = dropdownview
        dropdown.dataSource = Cities
        dropdown.bottomOffset =  CGPoint(x: 0, y: (dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.topOffset =  CGPoint(x: 0, y: -(dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.direction = .top
        dropdown.selectionAction = {(index:Int ,item :String) in
            print(self.City ?? "Other")
            self.dropdownlabel.text = self.Cities[index]
            self.City = self.Cities[index]
            print(self.City ?? "Other")
            
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
            backgroundimageview.image = UIImage(named: "Darktheme")
            view.sendSubviewToBack(backgroundimageview)
    
        }
    
    
    @IBAction func SignUp(_ sender:UIButton){
        // self.Signup()
       // let endpoint = "User/CreateNewAccount1"
        guard let email = self.txtEmail.text, email != "" else {
            Utility.alertMessage(title: "Error", message: "Enter Email")
            return
        }
        guard let email1 = self.txtEmail.text, email1.isValidEmail(email) else {
            Utility.alertMessage(title: "Error", message: "Email is not correct")
            return
        }
        guard let password = self.txtpassword.text, password != "" else {
            Utility.alertMessage(title: "Error", message: "Enter password")
            return
        }
        guard let phoneNo = self.txtphoneno.text, phoneNo != "" else {
            Utility.alertMessage(title: "Error", message: "Enter phoneNo")
            return
        }
        guard let Address = self.txtAddress.text, Address != "" else {
            Utility.alertMessage(title: "Error", message: "Enter Address")
            return
        }
        guard let Name = self.txtName.text, Name != "" else {
            Utility.alertMessage(title: "Error", message: "Enter Name")
            return
        }
        guard let city = self.City, city != "" else {
            Utility.alertMessage(title: "Error", message: "Select City")
            return
        }
        guard let role = self.Usertype, role != "" else {
            Utility.alertMessage(title: "Error", message: "Select Role")
            return
        }

        let api = APIWrapper()
        let userinfo = SignUpModel(Name: Name, Address: Address, PhoneNo: phoneNo, Email: email1, Password: password,City: city, UserType: role)
               let json = try! JSONEncoder().encode(userinfo)

               let response = api.postMethodCall(controllerName: "User", actionName: "CreateNewAccount1", httpBody: json)
               var message = ""
               if response.ResponseCode == 200 {
                   txtName.text = ""
                   txtphoneno.text = ""
                   txtEmail.text = ""
                   txtAddress.text = ""
                   txtpassword.text = ""
                   
                   message = response.ResponseMessage
               }else{
                   message = response.ResponseMessage
               }
               let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default))
               present(alert, animated: true, completion: nil)


    }
    @IBAction func SignIn(_ sender:UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    // self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
//    func Signup(){
//
//        let endpoint = "User/CreateNewAccount1"
//        guard let email = self.txtEmail.text, email != "" else {
//            Utility.alertMessage(title: "Error", message: "Enter Email")
//            return
//        }
//        guard let password = self.txtpassword.text, password != "" else {
//            Utility.alertMessage(title: "Error", message: "Enter password")
//            return
//        }
//        guard let phoneNo = self.txtphoneno.text, phoneNo != "" else {
//            Utility.alertMessage(title: "Error", message: "Enter phoneNo")
//            return
//        }
//        guard let Address = self.txtAddress.text, Address != "" else {
//            Utility.alertMessage(title: "Error", message: "Enter Address")
//            return
//        }
//        guard let Name = self.txtName.text, Name != "" else {
//            Utility.alertMessage(title: "Error", message: "Enter Name")
//            return
//        }
//        let params : [String:Any] = [
//            "Email":email,
//            "Password":password,
//            "Address":Address,
//            "Name":Name,
//            "PhoneNo":phoneNo,
//            "UserType":Usertype
//        ]
//
//  NetworkManager.shared.request(endpoint, decoder: LoginModel.self, method: .post, parameters: params, headers: nil) { results in
//            switch results {
//            case .success(let data):
//                print(data)
//                Utility.showAlertWithCustomButton(buttonTitle: "Ok", title: "Data Saved")
//
//            case .failure(let error):
//                print(error)
//                //show alert message
//                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
//
//            }
//        }
//    }
    
}


extension String {
    // abc@gmail.com
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailPred.evaluate(with: email)
        return result
    }
}
