//
//  vendorHomeViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 19/01/2023.
//

import UIKit

class vendorHomeViewController: UIViewController,UITabBarControllerDelegate,UIViewControllerTransitioningDelegate {
    @IBOutlet private weak var menuImageView:UIImageView!{
        didSet{
            menuImageView.addTapGesture {
                self.presentMenu()
            }
        }
    }
    @IBOutlet weak var vendorHometable: UITableView!
    @IBOutlet weak var Vendorname: UILabel!
    var allproducts = [vendorProducts](){
        didSet{
            DispatchQueue.main.async {
                self.vendorHometable.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Vendorname.text = UserSession.shared.user?.name
        GetAllProducts()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        vendorHometable.dataSource = self
        vendorHometable.delegate = self
        setBackground()
    }

    let backgroundimageview = UIImageView()
    func setBackground() {
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Darktheme")
        view.sendSubviewToBack(backgroundimageview)
        
    }
    
    func presentMenu() {
        let menuViewController2 = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "VendorMenuViewController") as! VendorMenuViewController
        menuViewController2.modalPresentationStyle = .custom
        menuViewController2.transitioningDelegate = self
        menuViewController2.delegate = self
        present(menuViewController2, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator(isPresenting: false)
    }
    
    
    
    func GetAllProducts(){
        
        let endpoint = "Product/VendorProducts"
        let vendorid = UserSession.shared.user?.acountId
        print(vendorid!)
        let params : [String:Any] = [
            "id":vendorid!,
            
        ]
        NetworkManager.shared.request(endpoint, decoder: [vendorProducts].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                
                
                self.allproducts = data
                print(self.allproducts)
                DispatchQueue.main.async {
                    self.vendorHometable.reloadData() // Reload the table view on the main thread
                }
                print("Done")
            case .failure(let error):
                print(error)
                
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
                
            }
        }
    }
    
    //    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    //        if viewController == self.tabBarController {
    //            // Selected the home tab
    //            self.GetAllProducts()
    //        }
    //    }
    
}
extension vendorHomeViewController :UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allproducts.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vendorHometable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VendorHomeTableViewCell
        let vendoraccount = allproducts[indexPath.row]
        
        cell.nameTextField.text = vendoraccount.productname
        cell.PriceField.text = "Rs:\(vendoraccount.price!)"
        cell.SizeTextField.text = vendoraccount.size!
        cell.QtyTextField.text = "Stock:\(vendoraccount.qty!)"
        let img = vendoraccount.image!
        
        let string = "http://192.168.6.48/FypFinalApi/Images/"+(vendoraccount.image!)
        let url = URL(string: string)
        // cell.imageViewPic?.downloaded(from: url!, contentMode: .scaleToFill)
        cell.imageViewPic.image = Utility.GetImageFromURL(name: vendoraccount.image!)
        cell.DetailButton.tag = indexPath.row
        cell.DetailButton.addTarget(self, action: #selector(detailtbutton), for: .touchUpInside)
        
        return cell;
    }
    @objc func detailtbutton(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let detail = allproducts[index]
        print(detail)
        //let id:Int
        //id = detail.productID!
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "VendorProductDetailsViewController") as! VendorProductDetailsViewController
        //        vc.nameTextField?.text = detail.productname!
        //        vc.SizeTextField?.text = detail.size!
        //        vc.PriceField?.text = "\(detail.price!)"
        //        vc.QTYTextField?.text = "\(detail.qty!)"
        //        vc.imageViewPic?.image = Utility.GetImageFromURL(name: detail.image!)
        
        vc.Allproducts = allproducts
        vc.indexpath = index
        self.navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true)
        
    }
}
extension vendorHomeViewController:VendorMenuViewControllerDelegate{
    func didPressProductRequest() {
        print("Request")
    }
    
    func didPressHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            RedirectHelper.shared.determineRoutes(storyBoard: .VendorDashboard)
        }
        print("Move whatever the home screen is")
    }
    
    func didPressProfile() {
        print("go to Profile screen")
    }
    
    
    
    
    func didPressLogout() {
        //remove session form userdefault.
        UserSession.shared.logout()
        print("Logout, remove session from user default and go to login screen or SplashScreen")
    }
    
    
}


//
//class MainViewController: UIViewController, UIViewControllerTransitioningDelegate {
//
//    func presentMenu() {
//        let menuViewController = UIViewController() // Replace with your menu view controller
//        menuViewController.modalPresentationStyle = .custom
//        menuViewController.transitioningDelegate = self
//        present(menuViewController, animated: true, completion: nil)
//    }
//
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        return LeftMenuPresentationController(presentedViewController: presented, presenting: presenting)
//    }
//}

