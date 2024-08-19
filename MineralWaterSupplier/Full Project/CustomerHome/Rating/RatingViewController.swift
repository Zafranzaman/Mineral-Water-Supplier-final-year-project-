//
//  RatingViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 20/05/2023.
//

import UIKit

class RatingViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var allproducts = [Products]()
    override func viewDidLoad() {
        super.viewDidLoad()
        GetAllProducts()
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "Customertabbar") as! UITabBarController
       //     self.navigationController?.pushViewController(vc, animated: true)
               vc.modalPresentationStyle = .fullScreen
               present(vc, animated: true,completion: nil)
        
    }
    func GetAllProducts(){
        
        let endpoint = "Product/AllProductsRating"
        print(UserSession.shared.user?.city ?? "a")
        let params : [String:String] = [
            "Cid":"\(UserSession.shared.user?.acountId ?? 0)"
           
        ]
        NetworkManager.shared.request(endpoint, decoder: [Products].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                print(data)
        
                self.allproducts = data
                self.tableview.reloadData()
                            case .failure(let error):
                print(error)
                
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
                
            }
        }
    }

}
extension RatingViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allproducts.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RatingTableViewCell
        let vendoraccount = allproducts[indexPath.row]
        cell.productName.text = allproducts[indexPath.row].productname ?? ""
        cell.productImage.image = Utility.GetImageFromURL(name: allproducts[indexPath.row].image ?? "")
        cell.rate.tag = indexPath.row
        cell.rate.addTarget(self, action: #selector(gotorate), for: .touchUpInside)
        return cell;
    }
    @objc func gotorate(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let detail = allproducts[index]
        print(detail)
        let id:Int
        id = detail.productID!
        let vid = detail.vendorID!
        print(id)
        let Customerid = UserSession.shared.user?.acountId
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "GiveRatingViewController") as! GiveRatingViewController
    
        vc.pid = id
        vc.vid = vid
        vc.cid = (UserSession.shared.user?.acountId!)!
        vc.pname = detail.productname ?? ""
        vc.imagename = detail.image!
         self.navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true,completion: nil)
       
    }
        
    
}
