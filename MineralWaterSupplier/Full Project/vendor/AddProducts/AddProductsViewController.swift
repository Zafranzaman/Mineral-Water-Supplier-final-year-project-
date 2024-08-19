//
//  AddProductsViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 25/02/2023.
//

import UIKit
import DropDown
class AddProductsViewController: UIViewController{
    @IBOutlet weak var chkspecialoffer: UIButton!
    let backgroundimageview = UIImageView()
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var SizeTextField: UITextField!
    
    @IBOutlet weak var QuantityTextField: UITextField!
    @IBOutlet weak var PriceField: UITextField!
    @IBOutlet weak var imageViewPic: UIImageView!
    var SpecialOffer = false;
    var stringImage = ""
    var selection:UIImage?
    var allwarehouse = [Product]()
    
    let dropDown = DropDown()
    
    var selectedItem :Product?{
        didSet{
            self.dropDownLabel.text = selectedItem?.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        Tabgesture()
        //self.imageViewPic.layer.cornerRadius = 64.0
        
        self.imageViewPic.layer.borderWidth = 1
        self.imageViewPic.layer.borderColor = UIColor.black.cgColor
        self.imageViewPic.layer.masksToBounds = true
        // self.imageViewPic.layer.cornerRadius = imageViewPic.frame.size.height/2
        // self.imageViewPic.clipsToBounds = true
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "warehouse", actionName: "AllWareHouse")
        if response.ResponseCode == 200 {
            
            do {
                allwarehouse = try JSONDecoder().decode([Product].self, from: response.ResponseData!)
                print("Total Warehouse :\(allwarehouse.count)")
                
                let productList = allwarehouse.map {
                    return $0.title ?? "No name of the warehouse"
                }
                dropDown.dataSource  = productList
                dropDown.reloadAllComponents()
            }catch {
                print("error: \(error)")
            }
            
            
        }else{
            print(response.ResponseMessage)
        }
        
        dropDown.anchorView = dropDownView
        //        dropDown.dataSource = ["Rwp","ISB","Karachi"]
        // Top of drop down will be below the anchorView
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            let orignalItem = self.allwarehouse.first {
                $0.title == item
            }
            print(orignalItem!)
            self.selectedItem = orignalItem
        }
        dropDown.direction = .any
        dropDownView.layer.borderWidth = 2
        dropDownView.layer.borderColor = UIColor.gray.cgColor
        dropDownView.layer.cornerRadius = 5
        
    }
    
    @IBAction func dropDownClick(_ sender: Any) {
        dropDown.show()
    }
    @IBAction func Logout(_ sender: Any) {
        UserSession.shared.logout()
    }
    func Tabgesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageViewPic.isUserInteractionEnabled = true
        imageViewPic.addGestureRecognizer(tapGesture)
        
    }
    @objc func pickImage(){
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .photoLibrary
        self.present(imgPicker, animated: true, completion: nil)
    }
    @IBAction func chkspecialofferClick(_ sender: UIButton) {
        
        if sender.tag == 1 {
            if chkspecialoffer.isSelected {
                chkspecialoffer.isSelected = false
                SpecialOffer = false ;
            }else{
                SpecialOffer = true;
                chkspecialoffer.isSelected = true
            }
            
        }
    }
    
    @IBAction func addProduct(_ sender:UIButton){
        
        
        let api = APIWrapper()
        
        
        
        
        
        
        guard let selectedItem = self.selectedItem else {return}
        let vendorid = UserSession.shared.user?.acountId
        let warehouseid = selectedItem.werehouseID!
        print(vendorid!)
        
        //print(selectedItem.werehouseID!)
        guard let Name = self.nameTextField.text, Name != "" else {
            Utility.alertMessage(title: "Error", message: "Enter Product Name")
            return
        }
        guard let Quantity = self.QuantityTextField.text, Quantity != "" else   {
            Utility.alertMessage(title: "Error", message: "Enter Quantity")
            return
        }
        guard let Size = self.SizeTextField.text, Size != "" else {
            Utility.alertMessage(title: "Error", message: "Enter Size")
            return
        }
        guard let Price = self.PriceField.text, Price != "" else {
            Utility.alertMessage(title: "Error", message: "Enter Price")
            return
        }
        //let url = URL(string: "http://192.168.0.174/FypFinalApi/api/product/addproduct")!
        
        guard let image = self.imageViewPic.image else {
            Utility.alertMessage(title: "Oops", message: "Please select a image")
            return
        }
        
        if let image = UIImage(named: "image.jpeg") {
            // Use the image object
        } else {
            // Handle error if the image cannot be loaded
        }
        guard let vendorid = vendorid else {return}
        
        print(stringImage)
        print(Name)
        print(Quantity)
        print(Size)
        print(Price)
        print(Name)
        print(warehouseid)
        let imageData = (selection?.pngData())!
        
        
        let params : [String:String] = [
            "name":Name,
            "qty":Quantity,
            "Size":Size,
            "Price":Price,
            "VendorID":"\(vendorid)",
            "WerehouseID":"\(warehouseid)",
            "SpecialOffer":"\(SpecialOffer)"
        ]
        
        let endpoint = "Product/Addproduct"
       
        
        let response = api.UploadImageToServerReal(cJson: imageData, endPoint: endpoint, params: params)
        var message = ""
        if response.ResponseCode == 200 {
            nameTextField.text = ""
            QuantityTextField.text = ""
            SizeTextField.text = ""
            PriceField.text = ""
            imageViewPic.image = UIImage(named: "")
            self.dropDownLabel.text = ""
            message = response.ResponseMessage
        }else{
            message = response.ResponseMessage
        }
        let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)

 
 
    }
    
    
    
    
    
    
}

extension AddProductsViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    func showImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageViewPic.image = image
            selection = image
            
            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
   
    
 
    func setBackground(){
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Darktheme")
        view.sendSubviewToBack(backgroundimageview)
        
    }
    
    
}

struct DefaultResponse:Codable{
    let status:Int?
}
