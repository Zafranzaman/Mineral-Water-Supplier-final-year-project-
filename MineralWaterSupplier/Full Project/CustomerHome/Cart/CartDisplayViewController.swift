//
//  CartDisplayViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 04/04/2023.
//

import UIKit

class CartDisplayViewController: UIViewController {
    @IBOutlet weak  var Tableview: UITableView!
    let backgroundimageview = UIImageView()
    @IBOutlet weak var Totalbill: UILabel!
    var totalqty = 0;
    var totalbill = 0.0
    var delivery = 200.0
    
    var cartsave = [OrderDetail]()
    var cartlist = [CustomerCart](){
        didSet{
            DispatchQueue.main.async {
                self.Tableview.reloadData()
            }
        }
    }
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        self.Tableview.delegate = self
        self.Tableview.dataSource = self
        
        DispatchQueue.main.async {
            self.GetAllProducts()
        }
        refreshControl.addTarget(self, action: #selector(GetAllProducts), for: .valueChanged)
        Tableview.refreshControl = refreshControl

        
    }
    
    
    
    @objc func GetAllProducts(){
        let endpoint = "Cart/CustomerProducts"
        let Customerid = UserSession.shared.user?.acountId
        let params : [String:Any] = [
            "id":Customerid!,
            
        ]
        NetworkManager.shared.request(endpoint, decoder: [CustomerCart].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                case .success(let data):
                print(data)
                self.refreshControl.endRefreshing()
                self.cartlist = data
                self.totalbill = 0.0
                for a in self.cartlist {
                    self.totalbill = self.totalbill + (Double(a.quantity ?? 0) * (a.price ?? 0.0))
                }
                self.Totalbill.text = "Total Bill:\(self.totalbill+self.delivery)"
                self.totalqty = 0
                for b in self.cartlist {
                    self.totalqty = self.totalqty + (b.quantity  ?? 0)
                }
          
            case .failure(let error):
                print(error)
                self.refreshControl.endRefreshing()
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
                
            }
            DispatchQueue.main.async {
                self.Tableview.reloadData()
            }
        }
    }
    
   @objc func totalcart(){
        let endpoint = "Cart/cartdata"
        let params : [String:Any] = [
            "id": UserSession.shared.user?.acountId!
        ]
        NetworkManager.shared.request(endpoint, decoder: [OrderDetail].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                print(data)
                self.cartsave = data
                //print(self.cartsave)
            case .failure(let error):
                print(error)
                //show alert message
                //Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
                
            }
        }
    }
    @IBAction private func Checkout(_ sender: UIButton){
//        if totalbill<1000 {
//            Utility.showAlertWithOkAndCancel(title: "Total Bill is less Then 1000")
//        }
//        else
//        {
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "PlaceOrderViewController") as! PlaceOrderViewController
            //     self.navigationController?.pushViewController(vc, animated: true)
            vc.totalbill = totalbill
            vc.totalqty = totalqty
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
        
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "Customertabbar") as! UITabBarController
       //     self.navigationController?.pushViewController(vc, animated: true)
               vc.modalPresentationStyle = .fullScreen
               present(vc, animated: true,completion: nil)
        
    }
    
}

extension CartDisplayViewController :UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartlist.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomerCartTableViewCell
        let cartproduct = cartlist[indexPath.row]
        cell.cartproduct = cartproduct
        cell.delegate = self
        return cell;
    }
    
    
    
    
}


extension CartDisplayViewController:CustomerCartTableViewCellDelegate{
    func setBackground() {
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Customertheme")
        view.sendSubviewToBack(backgroundimageview)
    }
    func didDeleteFormCart(cartItem: CustomerCart) {
        let params : [String:Any] = [
            "cid":cartItem.customerID ?? -1,
            "pid":cartItem.productID ?? -1
        ]
        let endpoint = "Cart/deleteProduct"
        NetworkManager.shared.request(endpoint, decoder: deletecartproduct.self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                print(data)
                Utility.alertMessage(title: "Deleted", message: "Product delete successfully 🎉")
                self.GetAllProducts()
            case .failure(let error):
                print(error)
                Utility.alertMessage(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func didIncreaseQuantity(cartItem: CustomerCart) {
        let params : [String:Any] = [
            
            "pid":cartItem.productID ?? -1,
            "cid":cartItem.customerID ?? -1,
            "qty":cartItem.quantity ?? 0
        ]
        print(cartItem.productID!)
        print(cartItem.customerID!)
        print(cartItem.quantity!)
        //        let endpoint = "Cart/Add"
        //        NetworkManager.shared.request(endpoint, decoder: Addqty.self, method: .patch, parameters: params, headers: nil) { results in
        //            switch results {
        //
        //            case .success(let data):
        //                print(data)
        //                Utility.alertMessage(title: "Increase", message: "Increase successfully 🎉")
        //                self.GetAllProducts()
        //            case .failure(let error):
        //                print(error)
        //                Utility.alertMessage(title: "Error", message: error.localizedDescription)
        //            }
        //        }
        let api = APIWrapper()
        let response = api.patchMethodCall(controllerName: "Cart", actionName: "Add", pid: cartItem.productID!, cid: cartItem.customerID!)
        var message = ""
        if response.ResponseCode == 200 {
            self.GetAllProducts()
            message = response.ResponseMessage
        }else{
            message = response.ResponseMessage
        }
        //        let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
        //        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        //        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    func didDecreaseQuantity(cartItem: CustomerCart) {
        
        let api = APIWrapper()
        let response = api.patchMethodCall(controllerName: "Cart", actionName: "Subtract", pid: cartItem.productID!, cid: cartItem.customerID!)
        var message = ""
        if response.ResponseCode == 200 {
            self.GetAllProducts()
            message = response.ResponseMessage
        }else{
            message = response.ResponseMessage
        }
    }
    
    
}


