//
//  SpecialofferViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 06/05/2023.
//

import UIKit

class SpecialofferViewController: UIViewController {

    let backgroundimageview = UIImageView()
    
    
    @IBOutlet weak var tableView: UITableView!
    var allproducts = [Products]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        GetAllProducts()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    


    func GetAllProducts(){
        
        let endpoint = "Product/AllSpecialProducts"
        let id:Int = 0
        let params : [String:Any] = [
            "id":id,
           
        ]
        NetworkManager.shared.request(endpoint, decoder: [Products].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                print(data)
        
                self.allproducts = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
                
            }
        }
    }
    
 
    
}

extension SpecialofferViewController {
    func setBackground() {
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Customertheme")
        view.sendSubviewToBack(backgroundimageview)
        
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "Customertabbar") as! UITabBarController
       //     self.navigationController?.pushViewController(vc, animated: true)
               vc.modalPresentationStyle = .fullScreen
               present(vc, animated: true,completion: nil)
        
    }
    @IBAction private func Cart(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "CartDisplayViewController") as! CartDisplayViewController
     self.navigationController?.pushViewController(vc, animated: true)
//        //present(vc, animated: true,completion: nil)
        //RedirectHelper.shared.determineRoutes(storyBoard: .Cart)
       
        
    }
}
extension SpecialofferViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allproducts.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpecailOfferTableViewCell
        
    
        
            cell.ProductName.text = allproducts[indexPath.row].productname!
            cell.ProductPrice.text = "Rs:\(allproducts[indexPath.row].price!)"
            cell.ProductImage.image = Utility.GetImageFromURL(name: allproducts[indexPath.row].image!)
        cell.AddToCart.tag = indexPath.row
        cell.AddToCart.addTarget(self, action: #selector(detailtbutton), for: .touchUpInside)
        return cell;
    }
    @objc func detailtbutton(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let detail = allproducts[index]
        print(detail)
        let id:Int
        id = detail.productID!
        print(id)
        let Customerid = UserSession.shared.user?.acountId
        let productInfo = AddToCart(ProductID: detail.productID, CustomerID: Customerid, Price: detail.price, Quantity: 1)
        self.AddTocart(cartdata: productInfo)
    }
    func AddTocart(cartdata:AddToCart) {
        
        let api = APIWrapper()
        
               let json = try! JSONEncoder().encode(cartdata)

               let response = api.postMethodCall(controllerName: "Cart", actionName: "AddToCart", httpBody: json)
               var message = ""
               if response.ResponseCode == 200 {
                   message = response.ResponseMessage
               }else{
                   message = response.ResponseMessage
               }
               let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default))
               present(alert, animated: true, completion: nil)

        
        
    }
   
      
      
    
}

