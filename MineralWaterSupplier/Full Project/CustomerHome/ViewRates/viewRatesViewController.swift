//
//  viewRatesViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 06/05/2023.
//

import UIKit

class viewRatesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let backgroundimageview = UIImageView()
    var products = [searchProducts]()
    var filteredProducts = [searchProducts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        GetAllProducts()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    var sizeofproducts = "A"
    func GetAllProducts(){
        
        let endpoint = "Product/searchProductascending"
        
        let params : [String:Any] = [
            "size":sizeofproducts,
            
        ]
        NetworkManager.shared.request(endpoint, decoder: [searchProducts].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
                
            case .success(let data):
                print(data)
                self.products = data
                self.filteredProducts = data
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
                
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
                
            }
            self.tableView.reloadData()
        }
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "Customertabbar") as! UITabBarController
        //     self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
}

extension  viewRatesViewController {
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
}
extension viewRatesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! viewRatesTableViewCell
        
        let product = filteredProducts[indexPath.row]
        
        cell.ProductName.text = product.productname ?? ""
        cell.ProductSize.text = product.size ?? ""
        cell.ProductPrice.text = "Rs: \(product.price ?? 0)"
        cell.ProductImage.image = Utility.GetImageFromURL(name: product.image ?? "")
        
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension viewRatesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sizeofproducts = searchText
        filterProducts(searchText: searchText)
        GetAllProducts()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        sizeofproducts = "a"
        filterProducts(searchText: "")
        searchBar.resignFirstResponder()
        GetAllProducts()
    }
    
    func filterProducts(searchText: String) {
        if searchText.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { product in
                return product.size?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        
        tableView.reloadData()
    }
}
