//
//  DeliveryBoyHomeViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 10/06/2023.
//

import UIKit

class DeliveryBoyHomeViewController: UIViewController {
var allOrders = [DeliveryBoyOrder]()
    @IBOutlet weak var tblranking: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Allorder()
        tblranking.delegate = self
        tblranking.dataSource = self
    }
    @IBAction func Logout(_ sender: Any) {
        UserSession.shared.logout()
    }

    @objc func Allorder() {
        let endpoint = "ManageOrder/DeliveryBoyOrders"
        
        let params: [String: Any] = ["did":UserSession.shared.user?.acountId ?? 0]
        NetworkManager.shared.request(endpoint, decoder: [DeliveryBoyOrder].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.allOrders = data
                print(self.allOrders)
               self.tblranking.reloadData()
            case .failure(_):
                Utility.showAlertWithOkAndCancel(title: "Error")
            }
        }
    }
}
extension DeliveryBoyHomeViewController :UITableViewDataSource, UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 517
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allOrders.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblranking.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryboyhomeTableViewCell
        let order = allOrders[indexPath.row]
        cell.Name.text = order.name
        cell.Oid.text = "OrderNo:\(order.oid ?? 0)"
        cell.TotalPrice.text = "Rs:\(order.totalPrice ?? 0)"
        cell.Contact.text = order.contact
        if order.package == nil{
            cell.package.text = ""
        }
        else
        {
            cell.package.text = order.package!
        }
        if order.mondayshift == nil{
            cell.monday.text = ""
        }
        else
        {
            cell.monday.text = order.mondayshift!
        }
        if order.tuesdayshift == nil{
            cell.tuesday.text = ""
        }
        else
        {
            cell.tuesday.text = order.tuesdayshift!
        }
        if order.wednesdayshift == nil{
            cell.wednesday.text = ""
        }
        else
        {
            cell.wednesday.text = order.wednesdayshift!
        }
        if order.thursdayshift == nil{
            cell.thursday.text = ""
        }
        else
        {
            cell.thursday.text = order.thursdayshift!
        }
        if order.fridayshift == nil{
            cell.friday.text = ""
        }
        else
        {
            cell.friday.text = order.fridayshift!
        }
        if order.saturdayshift == nil{
            cell.saturday.text = ""
        }
        else
        {
            cell.saturday.text = order.saturdayshift!
        }
        if order.sundayshift == nil{
            cell.sunday.text = ""
        }
        else
        {
            cell.sunday.text = order.sundayshift!
        }
        cell.StartRide.tag = indexPath.row
        cell.StartRide.addTarget(self, action: #selector(acceptbutton), for: .touchUpInside)
        return cell;
    }
    @objc func acceptbutton(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let accrequest = allOrders[index]
        print(accrequest)
        let id:Int
        id = accrequest.oid!
        self.Update(id: id)
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "StartRideViewController") as! StartRideViewController
        vc.orderlat = Double(accrequest.latitude!)
        vc.orderlong = Double(accrequest.longitude!)
        vc.oid = accrequest.oid!
        vc.Price = accrequest.totalPrice!
        vc.contact = accrequest.contact!
        vc.name = accrequest.name!
             self.navigationController?.pushViewController(vc, animated: true)
        
    }
        
        
        func Update(id:Int) {
            let api = APIWrapper()
            

                   let response = api.Patch(controllerName: "ManageOrder", actionName: "updateOrderStatusOnWay", id: id)
                   var message = ""
                   if response.ResponseCode == 200 {
                      
                       
                       message = "\(response.ResponseMessage)🎉"
                   }else{
                       message = response.ResponseMessage
                   }
                   let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: .default))
                   //present(alert, animated: true, completion: nil)
            
            
        }
    
}
