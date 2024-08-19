//
//  AddwarehouseViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 02/03/2023.
//

import UIKit
import MapKit
import CoreLocation

class AddwarehouseViewController: UIViewController,MKMapViewDelegate{
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var mMap: MKMapView!
    let locationManager = CLLocationManager()
    let backgroundimageview = UIImageView()
    
    var annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        mMap.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        annotation.title = "Current location"

    }
    
    @IBAction private func saveAction(_ sender: UIButton){
        print(annotation.coordinate)
        print(annotation.subtitle ?? "")
        
        
        guard let title = self.TitleText.text, title != "" else {
            Utility.alertMessage(title: "Error", message: "Enter Title")
            return
        }



        let api = APIWrapper()
        let addwarehouse = wareHouseAdd(Title: title, Latitude: annotation.coordinate.longitude, Longitude: annotation.coordinate.latitude, AdminId: UserSession.shared.user?.acountId ?? -1)
               let json = try! JSONEncoder().encode(addwarehouse)

               let response = api.postMethodCall(controllerName: "warehouse", actionName: "AddWarehouse", httpBody: json)
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
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AdminHomeViewController") as! AdminHomeViewController
        //     self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
}
    


extension AddwarehouseViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mMap.setRegion(region, animated: true)
        self.locationManager.stopUpdatingHeading()
        
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

extension AddwarehouseViewController {
    
    func setBackground() {
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Agency")
        view.sendSubviewToBack(backgroundimageview)
        
    }
}
