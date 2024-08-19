//
//  NewOrdersViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 25/05/2023.
//

import UIKit

class NewOrdersViewController: UIViewController {
    
    let backgroundimageview = UIImageView()
    var Allorderlist = [AllOrder]() {
        didSet {
            DispatchQueue.main.async {
                self.Tableview.reloadData()
            }
        }
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AdminHomeViewController") as! AdminHomeViewController
        //     self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        Allorder()
        Tableview.dataSource = self
        Tableview.delegate = self
    }
    @IBAction private func ConfirmedOrder(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "agencyOrderViewController") as! agencyOrderViewController
             self.navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true,completion: nil)
        
    }
    @objc func Allorder() {
        let endpoint = "ManageOrder/AllOrdersAdmin"
        
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
}

extension NewOrdersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Allorderlist.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewOrdersTableViewCell
        
        let order = Allorderlist[indexPath.row]
        cell.Name.text = order.name!
        cell.TotalPrice.text = "Price:\(order.totalPrice!)"
        cell.Contact.text = order.contact!
        cell.OrderNo.text = "OrderNo:\(order.oid!)"
        cell.AcceptButton.tag = indexPath.row
        cell.AcceptButton.addTarget(self, action: #selector(Acceptbutton), for: .touchUpInside)
        return cell;
    }
    @objc func Acceptbutton(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let detail = Allorderlist[index]
        print(detail)
        let oid:Int
        oid = detail.oid!
        Update(id: oid)
        
    }
    func Update(id:Int) {
        let api = APIWrapper()
        

               let response = api.Patch(controllerName: "ManageOrder", actionName: "updateOrderStatus", id: id)
               var message = ""
               if response.ResponseCode == 200 {
                  
                   
                   message = "\(response.ResponseMessage)🎉"
               }else{
                   message = response.ResponseMessage
               }
               let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default))
               present(alert, animated: true, completion: nil)
        Allorder()
        
    }

}
extension NewOrdersViewController {
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
