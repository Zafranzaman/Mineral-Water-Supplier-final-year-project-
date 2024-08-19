//
//  AssignOrderViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 26/05/2023.
//

import UIKit

class AssignOrderViewController: UIViewController {
    var oid = 0
    var Price = 0
    var deliveryBoys = [LoginModel]()
    @IBOutlet weak var Tableview: UITableView!
    let backgroundimageview = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        Allboys()
        
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AdminHomeViewController") as! AdminHomeViewController
        //     self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    @objc func Allboys() {
        let endpoint = "User/AlldeliveryBoys"
        
        let params: [String: Any] = [:]
        NetworkManager.shared.request(endpoint, decoder: [LoginModel].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.deliveryBoys = data
                self.Tableview.reloadData()
            case .failure(let error):
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
            }
        }
    }
}

extension AssignOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryBoys.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AssignOrderTableViewCell
        
        let order = deliveryBoys[indexPath.row]
        cell.Name.text = order.name!
        cell.Price.text = "Total Bill:\(Price)"
        
        cell.OrderNo.text = "OrderNo:\(oid)"
        cell.AssignOrder.tag = indexPath.row
        cell.AssignOrder.addTarget(self, action: #selector(Acceptbutton), for: .touchUpInside)
        return cell;
    }
    @objc func Acceptbutton(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let detail = deliveryBoys[index]
        print(detail)
        let did:Int
        did = detail.acountId!
        Update(did: did)
        
    }
    func Update(did:Int) {
        let api = APIWrapper()

        let userinfo = AssignOrder(Oid: oid, DeliveryboyID: did)
               let json = try! JSONEncoder().encode(userinfo)

               let response = api.postMethodCall(controllerName: "User", actionName: "Assigndeliveryboy", httpBody: json)
               var message = ""
               if response.ResponseCode == 200 {
                  
                   Update()
                   message = "\(response.ResponseMessage)🎊"
               }else{
                   message = response.ResponseMessage
               }
               let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default))
               present(alert, animated: true, completion: nil)
        
    }
    
    func Update() {
        let api = APIWrapper()
        

               let response = api.Patch(controllerName: "ManageOrder", actionName: "updateOrderStatusProcess", id: oid)
               var message = ""
               if response.ResponseCode == 200 {
                  
                   
                   message = "\(response.ResponseMessage)🎉"
               }else{
                   message = response.ResponseMessage
               }
               let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default))
              // present(alert, animated: true, completion: nil)
        
        
    }
}
extension AssignOrderViewController {
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
