//
//  TotalOrderAdminViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 19/01/2023.
//

import UIKit

class TotalOrderAdminViewController: UIViewController {
    let backgroundimageview = UIImageView()
    var Allorderlist = [AllOrder]() {
        didSet {
            DispatchQueue.main.async {
                self.Tableview.reloadData()
            }
        }
    }
    
//    @IBAction func didSegement(_ sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0 {
//            Allorder()
//        } else if sender.selectedSegmentIndex == 1 {
//            AllDeliveredorder()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        Allorder()
        Tableview.dataSource = self
        Tableview.delegate = self
    }
    
    @objc func Allorder() {
        let endpoint = "ManageOrder/CustomerOrders"
        
        let params: [String: Any] = ["cid":UserSession.shared.user?.acountId ?? 0]
        NetworkManager.shared.request(endpoint, decoder: [AllOrder].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.Allorderlist = data
                print(self.Allorderlist)
            case .failure(let error):
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
            }
        }
    }
    
//    @objc func AllDeliveredorder() {
//        let endpoint = "ManageOrder/AllOrders"
//
//        let params: [String: Any] = [:]
//        NetworkManager.shared.request(endpoint, decoder: [AllOrder].self, method: .get, parameters: params, headers: nil) { results in
//            switch results {
//            case .success(let data):
//                self.Allorderlist = data
//            case .failure(let error):
//                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
//            }
//        }
//    }
    
    @IBOutlet weak var Tableview: UITableView!
    var message = ""
}

extension TotalOrderAdminViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Allorderlist.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! totalorderadminTableViewCell
        
        let order = Allorderlist[indexPath.row]
        cell.Name.text = order.name!
        cell.TotalPrice.text = "Price:\(order.totalPrice!)"
        cell.Contact.text = order.contact!
        cell.OrderNo.text = "OrderNo:\(order.oid!)"
       
        let status = order.orderStatus!
        if(status == 0) {
            message = "Order Pending🕐"
            cell.status.text = message
        }
       else if(status == 1) {
           message = "Order Confirmed🎉"
            cell.status.text = message
        } else if(status == 2) {
            message = "Order Processing📦"
             cell.status.text = message
            
        } else if(status == 3) {
            message = "Order On Its Way🚚"
             cell.status.text = message
            
        }
        cell.detailButton.tag = indexPath.row
        cell.detailButton.addTarget(self, action: #selector(detailtbutton), for: .touchUpInside)
        return cell;
    }
    @objc func detailtbutton(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let detail = Allorderlist[index]
        print(detail)
        let id:Int
        id = detail.oid!
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
        vc.Allorderlist = Allorderlist
        vc.index = index
        vc.oid = id
        vc.cid = detail.customerID!
        vc.message = message
        vc.modalPresentationStyle = .fullScreen
       // self.dismiss(animated: true)
        present(vc, animated: true,completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
}
extension TotalOrderAdminViewController {
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
