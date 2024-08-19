//
//  ShowScheduleViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 28/05/2023.
//

import UIKit

class ShowScheduleViewController: UIViewController {
    let backgroundimageview = UIImageView()
    
    var Allschedules = [AllSchedule]()
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
           setBackground()
        GetAllschedule()
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    func GetAllschedule(){
        
        let endpoint = "Schedule/Allschedule"
       
        let params : [String:Any] = [
            "cid":UserSession.shared.user?.acountId ?? 0,
           
        ]
        NetworkManager.shared.request(endpoint, decoder: [AllSchedule].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                print(data)
        
                self.Allschedules = data
               
                self.tableview.reloadData()
            case .failure(let error):
                print(error)
                
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
                
            }
        }
    }

}
extension ShowScheduleViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Allschedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowScheduleTableViewCell
        
        let sc = Allschedules[indexPath.row]
        
        cell.name.text = sc.name ?? ""
        cell.contact.text = sc.phoneNo ?? ""
        cell.oid.text = "OrderNo: \(sc.orderID ?? 0)"
        cell.package.text = sc.package!
        return cell
    }
    
    
}

extension ShowScheduleViewController {
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
