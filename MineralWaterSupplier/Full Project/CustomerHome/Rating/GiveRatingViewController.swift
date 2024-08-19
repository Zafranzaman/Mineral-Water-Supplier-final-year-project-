import UIKit
import Cosmos

class GiveRatingViewController: UIViewController {
    @IBOutlet weak var ratingViewDelivery: CosmosView!
    @IBOutlet weak var ratingViewPacking: CosmosView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var pid = 0
    var vid = 0
    var cid = 0
    var pname = ""
    var imagename = ""
    var packing = 0
    var quality = 0
    var time = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pname)
        productName.text = pname
        
        productImage.image = Utility.GetImageFromURL(name: imagename)
        
        ratingView.didTouchCosmos = { rating in
            print("Rating A: \(rating)")
            self.quality = Int(rating)
        }
        ratingViewPacking.didTouchCosmos = { rating in
            print("Rating B: \(rating)")
            self.packing = Int(rating)
        }
        ratingViewDelivery.didTouchCosmos = { rating in
            print("Rating C: \(rating)")
            self.time = Int(rating)
        }
    }
    @IBAction private func back(_ sender: UIButton){
       
        
    }
    
    @IBAction func Rate(_ sender:UIButton){
        let api = APIWrapper()
        let userinfo = Addarating(CustomerID: cid, VendorID: vid, ProductID: pid, Packing: packing, Quality: quality, DeliveryTime: time)
        let json = try! JSONEncoder().encode(userinfo)
        
        let response = api.postMethodCall(controllerName: "Rating", actionName: "AddRating", httpBody: json)
        var message = ""
        if response.ResponseCode == 200 {
            message = response.ResponseMessage
            let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
//            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "RateViewController") as! UINavigationController
//           //     self.navigationController?.pushViewController(vc, animated: true)
//                   vc.modalPresentationStyle = .fullScreen
//                   present(vc, animated: true,completion: nil)
            
        }else{
            message = response.ResponseMessage
            let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
        }
        
    }
   
    
 
    
    
    
       
    }

