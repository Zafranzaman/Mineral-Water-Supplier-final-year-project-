//
//  PlaceOrderViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 13/05/2023.
//

import UIKit
import MapKit
import CoreLocation
import DropDown
class PlaceOrderViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    var locationlist = [Location]()
    let dropDown = DropDown()
    
    var selectedItem :Location?{
        didSet{
            self.dropDownLabel.text = selectedItem?.title
        }
    }
    
    
    
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var deliverychrges: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    var totalqty = 0
    var totalbill = 0.0
    var delivery = 200.0
    
    var cartsave = [OrderDetail]()
    @IBOutlet weak var mMap: MKMapView!
    let locationManager = CLLocationManager()
    var annotation = MKPointAnnotation()
       override func viewDidLoad() {
            super.viewDidLoad()
           getalllocation()
        subtotal.text = "\(totalbill)"
        deliverychrges.text = "\(200)"
        totalBillLabel.text = "\(totalbill+200)"
        
                        mMap.delegate = self
                        locationManager.delegate = self
                        locationManager.requestWhenInUseAuthorization()
                        locationManager.desiredAccuracy = kCLLocationAccuracyBest
                        locationManager.requestAlwaysAuthorization()
                        locationManager.startUpdatingLocation()
        
                        annotation.title = "Current location"
    }
  
    @IBAction private func Checkout(_ sender: UIButton){
        let endpoint = "Cart/cartdata"
        let params: [String:Any] = [
            "id": UserSession.shared.user?.acountId!
        ]
        NetworkManager.shared.request(endpoint, decoder: [OrderDetail].self, method: .get, parameters: params, headers: nil) { [self] results in
            switch results {
            case .success(let data):
                print(data)
                self.cartsave = data
                let api = APIWrapper()
                let order = AddOrder(
                    CustomerID: UserSession.shared.user?.acountId ?? 0,
                    Contact: UserSession.shared.user?.phoneNo ?? "0300-1234567",
                    TotalPrice: self.totalbill+self.delivery,
                    Quantity: self.totalqty,
                    City: UserSession.shared.user?.city ?? "",
                    Longitude: Float(self.annotation.coordinate.longitude),
                    Latitude: Float(annotation.coordinate.latitude),
                    carts: self.cartsave
                )
                let json = try! JSONEncoder().encode(order)
                let response = api.postMethodCall(controllerName: "ManageOrder", actionName: "AddnewOrder", httpBody: json)
                var message = ""
                if response.ResponseCode == 200 {
                    let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AddScheduleViewController") as! AddScheduleViewController
                   
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true,completion: nil)
                   // message = response.ResponseMessage
                } else {
                    message = response.ResponseMessage
                                    let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                    present(alert, animated: true, completion: nil)
                }
                print(message)

            case .failure(let error):
                print(error)
                //show alert message
                //Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
            }
        }
        
    }

    
    
    func getalllocation(){
        let api = APIWrapper()
        var id = UserSession.shared.user?.acountId ?? 0
        let response = api.getLocationMethod(controllerName: "User", actionName: "getlocation",id: id)
        if response.ResponseCode == 200 {
            
            do {
                locationlist = try JSONDecoder().decode([Location].self, from: response.ResponseData!)
                print("Total location :\(locationlist.count)")
                
                let locList = locationlist.map {
                    return $0.title ?? "No list found"
                }
                dropDown.dataSource  = locList
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
            
            let orignalItem = self.locationlist.first {
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
    
    
    
    
}

    
    
    extension PlaceOrderViewController: CLLocationManagerDelegate {
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else {return}
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.mMap.setRegion(region, animated: true)
            self.locationManager.stopUpdatingLocation()
    
            self.updateLocationName(coordinate: center)
    
        }
    
        func updateLocationName(coordinate: CLLocationCoordinate2D){
    
            // Set the coordinate of the annotation to the user's current location
            self.annotation.coordinate = coordinate
    
            let geocoder = CLGeocoder()
            var name = ""
            geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { (placemarks, error) in
                // If there was an error, handle it here
                if let error = error {
                    assertionFailure("Reverse geocoding failed with error: \(error.localizedDescription)")
                    return
                }
    
                // If there are no placemarks, handle it here
                guard let placemarks = placemarks, let placemark = placemarks.first else {
                    assertionFailure("No placemarks found for the given location")
                    return
                }
    
                name = placemark.name ?? placemark.locality ?? placemark.country ?? "Unknown"
    
                self.annotation.subtitle = name
    
                // Add the annotation to the map view
                self.mMap.addAnnotation(self.annotation)
            }
        }
    
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Check that the annotation is not the user's location
            guard !(annotation is MKUserLocation) else {
                return nil
            }
            let identifier = "customAnnotation"
    
    //        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    
            // Create a new MKPinAnnotationView instance and set its properties
            if annotationView == nil {
                  // If no existing view was found, create a new one
                  annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
              } else {
                  // If an existing view was found, reuse it
                  annotationView?.annotation = annotation
              }
    
            annotationView?.canShowCallout = true
            annotationView?.isDraggable = true
            annotationView?.image = UIImage(named: "pin")
    
            return annotationView
        }
    
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            if newState == .ending {
                // Get the new location of the annotation
                guard let newCoordinate = view.annotation?.coordinate else {return}
                self.updateLocationName(coordinate: newCoordinate)
            }
        }
    
    }

