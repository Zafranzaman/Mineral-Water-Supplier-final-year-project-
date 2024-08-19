import UIKit
import MapKit

class StartRideViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!

    var orderlat = 0.0
    var orderlong = 0.0
    var oid = 0
    var Price = 0
    var contact = ""
    var name = ""
    var savelat = 0.0
    var savelong = 0.0
    let locationManager = CLLocationManager()
    @IBAction func back(_ sender: Any) {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "DeliveryBoyHomeViewController") as! DeliveryBoyHomeViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    func saveData() {
        let api = APIWrapper()
               
               // Retrieve the latest location coordinates
               let currentLocation = locationManager.location?.coordinate
               
               let userinfo = OrderLocationData(Oid: oid, Did: UserSession.shared.user?.acountId!, OrderLat: Float(orderlat), OrderLong: Float(orderlong), dLat: Float(currentLocation?.latitude ?? 0.0), dlong: Float(currentLocation?.longitude ?? 0.0), DeliveryBoyname: UserSession.shared.user?.name!, DeliveryBoyContact: UserSession.shared.user?.phoneNo!)
               
               let json = try! JSONEncoder().encode(userinfo)
               
               let response = api.postMethodCall(controllerName: "Cart", actionName: "AddOrderLocation", httpBody: json)
               var message = ""
               
               if response.ResponseCode == 200 {
                   message = response.ResponseMessage
               } else {
                   message = response.ResponseMessage
               }
               
               let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default))
               //present(alert, animated: true, completion: nil)
    }
    var StockList = [GetStock]()
    var sendList = [SendStock]()
    @objc func Stock() {
        let endpoint = "ManageOrder/GetStock"
        
        let params: [String: Any] = ["oid":oid]
        NetworkManager.shared.request(endpoint, decoder: [GetStock].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.StockList = data
               

                // Print the sendList
                for sendStockItem in self.sendList {
                    print(sendStockItem)
                }
                print(self.StockList)
                print("tapped")
            case .failure(_):
                Utility.showAlertWithOkAndCancel(title: "Error")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Stock()
        // Set the map view delegate
        mapView.delegate = self

        // Request location authorization
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()

        // Add pin annotation for order location
        let orderCoordinate = CLLocationCoordinate2D(latitude: orderlat, longitude: orderlong)
        let orderAnnotation = CustomAnnotation(coordinate: orderCoordinate, title: "Order Location", image: UIImage(named: "pin"))
        mapView.addAnnotation(orderAnnotation)
        mapView.showAnnotations([orderAnnotation], animated: true)
        
        // Update UI elements
        OrderLabel.text = "OrderNo: \(oid)"
        ContactLabel.text = contact
        TotalpriceLabel.text = "Rs: \(Price)"
        
        // Save data
        saveData()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Save the current location coordinates
        savelat = location.coordinate.latitude
        savelong = location.coordinate.longitude
        
        // Remove previous vehicle annotation
        mapView.removeAnnotations(mapView.annotations.filter { $0 !== mapView.userLocation })
        
        // Add vehicle annotation at current location
        let vehicleAnnotation = CustomAnnotation(coordinate: location.coordinate, title: "Delivery Location", image: UIImage(named: "vehicle.png"))
        mapView.addAnnotation(vehicleAnnotation)
        
        // Add line between order and vehicle locations
        let orderCoordinate = CLLocationCoordinate2D(latitude: orderlat, longitude: orderlong)
        let coordinates: [CLLocationCoordinate2D] = [orderCoordinate, location.coordinate]
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
    }


    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 2
            return renderer
        }

        return MKOverlayRenderer(overlay: overlay)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            // Return nil for the default user location annotation view
            return nil
        }

        let reuseIdentifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView?.annotation = annotation
        }

        // Configure the annotation view
        if let customAnnotation = annotation as? CustomAnnotation {
            annotationView?.image = customAnnotation.image
            annotationView?.centerOffset = CGPoint(x: 0, y: -(annotationView?.image?.size.height ?? 0) )
        }

        return annotationView
    }
    
    @IBOutlet weak var OrderLabel: UILabel!
    @IBOutlet weak var TotalpriceLabel: UILabel!
    @IBOutlet weak var ContactLabel: UILabel!
    
    func sendstock(pid:Int,qty:Int) {
        let api = APIWrapper()
       
        do {
            
            
            let response = api.patchStockMethodCall(controllerName: "ManageOrder", actionName: "UpdateStock",pid: pid,qty: qty)
            
            var message = ""
            if response.ResponseCode == 200 {
                message = response.ResponseMessage
            } else {
                message = response.ResponseMessage
            }
            
            let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
           // present(alert, animated: true, completion: nil)
            
        } catch {
            print("Error encoding StockList: \(error)")
        }
    }

    @IBAction func Delivered(_ sender: Any) {
        for stockItem in self.StockList {
            sendstock(pid:stockItem.productID!,qty:stockItem.quantity!)
        }
        
        let api = APIWrapper()
           

                  let response = api.Patch(controllerName: "ManageOrder", actionName: "updateOrderStatusDelivered", id: oid)
                  var message = ""
                  if response.ResponseCode == 200 {
                     
                      let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "DeliveryBoyHomeViewController") as! DeliveryBoyHomeViewController
                      
                      vc.modalPresentationStyle = .fullScreen
                      present(vc, animated: true,completion: nil)

                      message = "\(response.ResponseMessage)🎉"
                  }else{
                      message = response.ResponseMessage
                  }
                  let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Ok", style: .default))
                  present(alert, animated: true, completion: nil)
           
    }
}

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var image: UIImage?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, image: UIImage? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.image = image
    }
}
