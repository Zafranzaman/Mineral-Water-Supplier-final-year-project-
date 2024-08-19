//
//  agencyOrderViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 24/05/2023.
//

import UIKit

class agencyOrderViewController: UIViewController {
    let backgroundimageview = UIImageView()
    var Allorderlist = [AllOrder]() {
        didSet {
            DispatchQueue.main.async {
                self.Tableview.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        Allorder()
        Tableview.dataSource = self
        Tableview.delegate = self
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "agencyOrderViewController") as! agencyOrderViewController
        //     self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    @objc func Allorder() {
        let endpoint = "ManageOrder/AllOrdersnew"
        
        let params: [String: Any] = ["city":UserSession.shared.user?.city ?? "a"]
        NetworkManager.shared.request(endpoint, decoder: [AllOrder].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.Allorderlist = data
                self.Tableview.reloadData()
            case .failure(let error):
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
            }
        }
    }
    
    
    @IBOutlet weak var Tableview: UITableView!
    var message = ""
    var message1 = ""
}

extension agencyOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Allorderlist.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! agencyOrderTableViewCell
        
        let order = Allorderlist[indexPath.row]
        cell.Name.text = order.name!
        cell.TotalPrice.text = "Price:\(order.totalPrice!)"
        cell.Contact.text = order.contact!
        cell.OrderNo.text = "OrderNo:\(order.oid!)"
        let status = order.orderStatus!
        if(status == 0) {
            message1 = "Order Pending🕐"
            cell.status.text = message1
        }
       else if(status == 1) {
           message1 = "Order Confirmed🎉"
            cell.status.text = message1
        } else if(status == 2) {
            message1 = "Order Processing📦"
             cell.status.text = message1
            
        } else if(status == 3) {
            message1 = "Order On Its Way🚚"
             cell.status.text = message1
            
        }
        cell.DetailButton.tag = indexPath.row
        cell.DetailButton.addTarget(self, action: #selector(Acceptbutton), for: .touchUpInside)
        return cell;
    }
    @objc func Acceptbutton(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let detail = Allorderlist[index]
        print(detail)
        let orderid:Int
        orderid = detail.oid!
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "agencyOrderDetailsViewController") as! agencyOrderDetailsViewController
        vc.oid = orderid
        vc.price = detail.totalPrice!
             self.navigationController?.pushViewController(vc, animated: true)
      
        
    }

}
extension agencyOrderViewController {
    func setBackground(){
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Agency")
        view.sendSubviewToBack(backgroundimageview)
        
    }
}
