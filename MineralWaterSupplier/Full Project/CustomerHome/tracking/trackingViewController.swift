import UIKit
import MapKit
import CoreLocation

class trackingViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var orderId: Int = 0
    let backgroundImageview = UIImageView()
    var allOrders: [GetOrderLocationData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        orderNumberLabel.text = "OrderNo: \(orderId)"
        setBackground()
        getData()
        let zoomInButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(zoomIn))
                let zoomOutButton = UIBarButtonItem(title: "-", style: .plain, target: self, action: #selector(zoomOut))
                navigationItem.rightBarButtonItems = [zoomInButton, zoomOutButton]
          
    }

    func setBackground() {
        view.addSubview(backgroundImageview)
        backgroundImageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageview.image = UIImage(named: "Customertheme")
        view.sendSubviewToBack(backgroundImageview)
    }

    func getData() {
        let endpoint = "Cart/GetOrderLocation"
        let params: [String: Any] = ["oid": orderId]
        
        NetworkManager.shared.request(endpoint, decoder: [GetOrderLocationData].self, method: .get, parameters: params, headers: nil) { [weak self] result in
            switch result {
            case .success(let data):
                self?.allOrders = data
                print(self?.allOrders ?? [])

                // Update UI elements with data
                if let firstOrder = self?.allOrders.first {
                    DispatchQueue.main.async {
                        self?.nameLabel.text = firstOrder.deliveryBoyname ?? ""
                        self?.contactLabel.text = firstOrder.deliveryBoyContact ?? ""
                        self?.configureMapView()
                    }
                }
                
            case .failure(_):
                Utility.showAlertWithOkAndCancel(title: "Error")
            }
        }
    }
    
    func configureMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true

        // Add pins and draw line
        if allOrders.count >= 1, let order = allOrders.first {
            let sourceCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(order.orderLat ?? 0.0), longitude: CLLocationDegrees(order.orderlong ?? 0.0))
            let destinationCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(order.dLat ?? 0.0), longitude: CLLocationDegrees(order.dlong ?? 0.0))
            
            let sourceAnnotation = CustomAnnotation1(coordinate: sourceCoordinate, title: "Order Location", image: UIImage(named: "pin")!)
            mapView.addAnnotation(sourceAnnotation)

            let destinationAnnotation = CustomAnnotation1(coordinate: destinationCoordinate, title: "Delivery Location", image: UIImage(named: "vehicle.png")!)
            mapView.addAnnotation(destinationAnnotation)


            
            let coordinates: [CLLocationCoordinate2D] = [sourceCoordinate, destinationCoordinate]
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            mapView.addOverlay(polyline)
            
            // Adjust map region to fit the annotations
            let region = MKCoordinateRegion(center: sourceCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let customAnnotation = annotation as? CustomAnnotation1 {
            let identifier = "CustomAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: customAnnotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = customAnnotation
            }
            annotationView?.image = customAnnotation.image
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    @objc func zoomIn() {
            var region = mapView.region
            region.span.latitudeDelta /= 2
            region.span.longitudeDelta /= 2
            mapView.setRegion(region, animated: true)
        }
        
        @objc func zoomOut() {
            var region = mapView.region
            region.span.latitudeDelta *= 2
            region.span.longitudeDelta *= 2
            mapView.setRegion(region, animated: true)
        }
}

class CustomAnnotation1: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var image: UIImage?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, image: UIImage?) {
        self.coordinate = coordinate
        self.title = title
        self.image = image
    }
}

