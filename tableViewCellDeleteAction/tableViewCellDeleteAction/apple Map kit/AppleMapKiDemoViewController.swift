//
//  AppleMapKiDemoViewController.swift
//  tableViewCellDeleteAction
//
//  Created by Piyush Naranje on 12/04/22.
//
import MapKit
import UIKit
import CoreLocation
class AppleMapKiDemoViewController: UIViewController {
    
    @IBOutlet var getroutebtn: UIButton!
    @IBOutlet var suknaLakebtn: UIButton!
    @IBOutlet var myhomebtn: UIButton!
    @IBOutlet var mapView: MKMapView!
    let manager = CLLocationManager()
    var newLocation = (latitude:30.709578,longitude:76.688673)
    var pintittle = "Live location"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setbtnLayout()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.mapView.delegate = self
    }
    func setbtnLayout(){
        getroutebtn.layer.cornerRadius = 25
        myhomebtn.layer.cornerRadius = 25
        suknaLakebtn.layer.cornerRadius = 25
    }
    @IBAction func myHomeDirection(_ sender: UIButton) {
        self.newLocation = (21.10646,79.08858)
        self.pintittle = "My Home"
        manager.startUpdatingLocation()
    }
    @IBAction func sukhnaLakeDIrection(_ sender: UIButton) {
        self.pintittle = "Sukhna Lake"
        self.newLocation = (30.74517,76.81045)
        manager.startUpdatingLocation()
    }
    @IBAction func liveLocationbtnclickAction(_ sender: UIButton) {
        self.newLocation = (30.709578,76.688673)
        manager.startUpdatingLocation()
    }
    
    @IBAction func getRouteClickAction(_ sender: UIButton) {
        let sourceCoordinate = CLLocationCoordinate2D(latitude: 30.709578, longitude: 76.688673)
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 30.74517, longitude: 76.81045)

         let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate,addressDictionary: nil)
         let destPlaceMark = MKPlacemark(coordinate: destinationCoordinate,addressDictionary: nil)

         let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
         let destMapItem = MKMapItem(placemark: destPlaceMark)

        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.transportType = .automobile
        directionRequest.destination = destMapItem

        let direction = MKDirections(request: directionRequest)
        direction.calculate { (response, error) in
            guard let response = response else{
                if let error = error{
                    print("error while caliculating route")
                }
                return
            }
            let route = response.routes [0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
}
extension AppleMapKiDemoViewController: CLLocationManagerDelegate,MKMapViewDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
//            location coordinate
            let coordinate = CLLocationCoordinate2D(latitude: newLocation.latitude, longitude: newLocation.longitude )
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let region = MKCoordinateRegion(center: coordinate , span: span)
            mapView.setRegion(region, animated: true)
//            mark for the location
            let pin = MKPointAnnotation()
            pin.title = pintittle
            pin.coordinate = coordinate
            mapView.addAnnotation(pin)
        }
    }

//    MARK: Polyline Properties
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.lineWidth = 10
        render.strokeColor = .red
        return render
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
