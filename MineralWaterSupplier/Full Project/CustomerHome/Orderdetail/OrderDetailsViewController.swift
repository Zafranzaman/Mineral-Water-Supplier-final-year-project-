//
//  OrderDetailsViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 19/01/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    let backgroundimageview = UIImageView()
    var orderDetailList = [OrderDetailList]()
    var status = 0
    var message = ""
    var oid = 0
    var cid = 0
    var Allorderlist = [AllOrder]()
    var index = 0
    @IBOutlet weak var Tableview: UITableView!
    @IBOutlet weak var OrderNo: UILabel!
    @IBOutlet weak var Contact: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var TotalPrice: UILabel!
    @IBOutlet weak var Deliveryprice: UILabel!
    @IBOutlet weak var TotalBill: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        Status.text = message
        OrderDetail()
        Tableview.dataSource = self
        Tableview.delegate = self
//        Name.text = Allorderlist[index].name!
//        Contact.text = Allorderlist[index].contact!
        TotalBill.text = "\(Allorderlist[index].totalPrice!-200)"
        TotalPrice.text = "\(Allorderlist[index].totalPrice!)"
        //OrderNo.text = "OrderNo:\(Allorderlist[index].oid!)"
        status = Allorderlist[index].orderStatus!
    }
    
    @IBAction func Logout(_ sender: Any) {
        UserSession.shared.logout()
    }
    @IBAction private func UpdateStatusAction(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "UpdateStatusAdminViewController") as! UpdateStatusAdminViewController
        vc.status = status
        vc.oid = oid
       // self.dismiss(animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
    }
    
    @objc func OrderDetail() {
        let endpoint = "Orderdetails/OrderDetail"
        print("cheeck")
        print(oid)
        print(cid)
        let params: [String: Any] = [
            "oid":oid,
            "cid":cid
        ]
        NetworkManager.shared.request(endpoint, decoder: [OrderDetailList].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.orderDetailList = data
                print(self.orderDetailList)
                self.Tableview.reloadData()
            case .failure(let error):
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
            }
        }
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "Customertabbar") as! UITabBarController
        //     self.navigationController?.pushViewController(vc, animated: true)
        self.dismiss(animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
}
extension OrderDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetailList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderDetailTableViewCell
        
        let order = orderDetailList[indexPath.row]
        cell.itemName.text = order.productName!
        cell.itemPrice.text = "\(order.price! * order.quantity!)"
        cell.quantity.text = "\(order.quantity!)"
        cell.itemSize.text = order.size
        
        return cell;
    }
    //    @objc func detailtbutton(sender:UIButton){
    //        let data = IndexPath(row: sender.tag, section: 0)
    //        print(data.row)
    //        let index = data.row
    //        let detail = Allorderlist[index]
    //        print(detail)
    //        let id:Int
    //        id = detail.oid!
    //        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
    //        vc.oid = id
    //     present(vc, animated: true)
    //
    //   }
    
}
extension OrderDetailsViewController {
    func setBackground(){
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Customertheme")
        view.sendSubviewToBack(backgroundimageview)
        
    }
}
