//
//  CustomerHomeViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 14/01/2023.
//

import UIKit

class CustomerHomeViewController: UIViewController ,UIViewControllerTransitioningDelegate{
    let backgroundimageview = UIImageView()
    var name:UILabel!
    
    @IBOutlet private weak var menuImageView:UIImageView!{
        didSet{
            menuImageView.addTapGesture {
                self.presentMenu()
            }
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    var allproducts = [RatingProducts]()
    var searchproducts = [RatingProducts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //name.text = UserSession.shared.user?.name!
        //setBackground()
        GetAllProducts()
        searchBar.delegate = self
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
    }
    


    func GetAllProducts(){
        
        let endpoint = "Product/AllProductsa"
        print(UserSession.shared.user?.city ?? "a")
        let params : [String:String] = [
            "Ccity":UserSession.shared.user?.city ?? "a",
           
        ]
        NetworkManager.shared.request(endpoint, decoder: [RatingProducts].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                print(data)
        
                self.allproducts = data
                self.searchproducts = self.allproducts
                self.CollectionView.reloadData()
            case .failure(let error):
                print(error)
                
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
                
            }
        }
    }
//    @IBAction func cartscreen(_ sender: Any) {
//        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "CartDisplayViewController") as! CartDisplayViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    @IBAction func Logout(_ sender: Any) {
        UserSession.shared.logout()
    }
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        searchBar.endEditing(true)
//    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func presentMenu() {
        let menuViewController1 = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "CustomerMenuViewController") as! CustomerMenuViewController
        menuViewController1.modalPresentationStyle = .custom
        menuViewController1.transitioningDelegate = self
        menuViewController1.delegate = self
        present(menuViewController1, animated: true, completion: nil)
    }
 
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator(isPresenting: false)
    }
}

extension CustomerHomeViewController {
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
    @IBAction func SpecialOffer(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "WeeklyScheduleViewController") as! WeeklyScheduleViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        vc.oid = 78
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    @IBAction func schedule(_ sender: Any) {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SpecialofferViewController") as! SpecialofferViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    @IBAction private func Cart(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "CartDisplayViewController") as! CartDisplayViewController
    // self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        //RedirectHelper.shared.determineRoutes(storyBoard: .Cart)
       
        
    }
}
extension CustomerHomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchproducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomerHomeCollectionViewCell
        
            cell.ProductName.text = searchproducts[indexPath.row].productname!
            cell.ProductPrice.text = "Rs:\(searchproducts[indexPath.row].price!)"
            cell.ProductImage.image = Utility.GetImageFromURL(name: searchproducts[indexPath.row].image!)
        cell.Rating.text = "\(searchproducts[indexPath.row].averageRating!)/5"
        if let rating = searchproducts[indexPath.row].averageRating {
                cell.ratingView.rating = Double(rating)
                
            } else {
                // Handle case when rating is nil
                cell.ratingView.rating = 0
            
            }
            cell.ratingView.settings.fillMode = .precise
            cell.ratingView.settings.updateOnTouch = false
        cell.AddToCart.tag = indexPath.row
        cell.AddToCart.addTarget(self, action: #selector(detailtbutton), for: .touchUpInside)
        return cell;
    }
    @objc func detailtbutton(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        print(data.row)
        let index = data.row
        let detail = searchproducts[index]
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          // Filter the data based on the search text
        searchproducts = allproducts.filter({ $0.productname!.contains(searchText) })
          
          // Reload the collection view with the filtered data
        
          CollectionView.reloadData()
      }
      
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          // If the user cancels the search, reset the filtered data to be the same as the original data
          searchproducts = allproducts
          
          // Reload the collection view with the original data
          CollectionView.reloadData()
      }
    
}
extension CustomerHomeViewController:CustomerMenuViewControllerDelegate{
    func didPressHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            RedirectHelper.shared.determineRoutes(storyBoard: .Customer)
        }
        print("Move whatever the home screen is")
    }
    
    func didPressProfile() {
        print("go to Profile screen")
    }
    func didPressViewPrice() {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "viewRatesViewController") as! viewRatesViewController
        self.dismiss(animated: true)
    // self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: true,completion: nil)
    }
    func didPressSetLocation() {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "saveLocViewController") as! saveLocViewController
        self.dismiss(animated: true)
    // self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: true,completion: nil)
    }
    func didPressRating() {
        print("go to Rating screen")
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "RateViewController") as! RateViewController
        self.dismiss(animated: true)
    // self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: true,completion: nil)
    }
    
    func didPressLogout() {
        //remove session form userdefault.
        UserSession.shared.logout()
        print("Logout, remove session from user default and go to login screen or SplashScreen")
    }
    
    
}
