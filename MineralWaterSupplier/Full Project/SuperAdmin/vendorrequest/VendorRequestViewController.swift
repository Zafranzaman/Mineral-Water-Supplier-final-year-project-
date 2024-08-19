//
//  VendorRequestViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 19/01/2023.
//

import UIKit

class VendorRequestViewController: UIViewController {
    
    var allvendors = [LoginModel](){
        didSet{
            DispatchQueue.main.async {
                self.tblranking.reloadData()
            }
        }
    }
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground() 
        tblranking.dataSource = self
        tblranking.delegate = self
        DispatchQueue.main.async {
            self.fetchData()
        }
        
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        tblranking.refreshControl = refreshControl
        
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SuperAdminHomeViewController") as! SuperAdminHomeViewController
        //     self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    @objc func fetchData(){
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "User", actionName: "vendoraccountverification")
        if response.ResponseCode == 200 {
            self.refreshControl.endRefreshing()
            
            allvendors = try! JSONDecoder().decode([LoginModel].self, from: response.ResponseData!)
            print("Total Warehouse :\(allvendors.count)")
            
        }else{
            self.refreshControl.endRefreshing()
            print(response.ResponseMessage)
        }
    }
    let backgroundimageview = UIImageView()
    @IBOutlet weak var tblranking: UITableView!
    func setBackground() {
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "super")
        view.sendSubviewToBack(backgroundimageview)
        
    }
}

extension VendorRequestViewController :UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allvendors.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblranking.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! vendorrequestcellTableViewCell
        let vendoraccount = allvendors[indexPath.row]
        cell.AcceptButton.tag = indexPath.row
        cell.AcceptButton.addTarget(self, action: #selector(acceptbutton), for: .touchUpInside)
        let name = vendoraccount.name
        let id = vendoraccount.acountId
        cell.lbno?.text = ("\(id!)")
        cell.lbname?.text = name
        
        
        return cell;
    }
    
    @objc func acceptbutton(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let accrequest = allvendors[index]
        print(accrequest)
        let id:Int
        id = accrequest.acountId!
        self.Update(id: id)
        tblranking.reloadData()
        
    }
    
    func Update(id:Int) {
        
        
        
        let params : [String:Any] = [
            "id":id,
            
        ]
        let endpoint = "User/Accountrequest?id=\(id)"
        NetworkManager.shared.request(endpoint, decoder: LoginModel.self, method: .patch, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                print(data)
                Utility.alertMessage(title: "Alert!", message: "Account is Verified")
                
                //next setp, fetch the most recent data form the api/database.
                self.fetchData()
            case .failure(let error):
                print(error)
                //show alert message
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
                
            }
        }
    }
    
    
}

