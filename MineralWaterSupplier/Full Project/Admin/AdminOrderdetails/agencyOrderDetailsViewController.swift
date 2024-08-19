//
//  agencyOrderDetailsViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 26/05/2023.
//

import UIKit

class agencyOrderDetailsViewController: UIViewController {
    let backgroundimageview = UIImageView()
    var oid = 0
    var price = 0
    @IBOutlet weak var Tableview: UITableView!
    @IBOutlet weak var OrderNo: UILabel!
    var orderDetailList = [OrderDetailList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        OrderNo.text = "OrderNo:\(oid)"
        OrderDetail()
        Tableview.delegate = self
        Tableview.dataSource = self
    }
    @IBAction func assignOrder(_ sender: Any) {
        
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AssignOrderViewController") as! AssignOrderViewController
            //     self.navigationController?.pushViewController(vc, animated: true)
        vc.oid = oid
        vc.Price = price
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
        
    }
    @IBAction func updateOrderStatus(_ sender: Any) {
       
    }
    @objc func OrderDetail() {
        let endpoint = "Orderdetails/AgencyOrderDetail"
        print(oid)
        let params: [String: Any] = [
            "oid":oid
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

}
extension agencyOrderDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetailList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! agencyorderdetailsTableViewCell
        
        let order = orderDetailList[indexPath.row]
        cell.itemName.text = order.productName!
        cell.itemPrice.text = "\(order.price!)"
        cell.quantity.text = "\(order.quantity!)"
        cell.itemSize.text = order.size
        
        return cell;
    }
    
}
extension agencyOrderDetailsViewController {
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
