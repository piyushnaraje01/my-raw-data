//
//  subDataViewController.swift
//  API calling
//
//  Created by Piyush Naranje on 18/04/22.
//

import UIKit
import MapKit
import CoreLocation

class subDataViewController: UIViewController {
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var idNoInfo: UILabel!
    @IBOutlet var phoneNumberLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var zipcodeLbl: UILabel!
    @IBOutlet var streetNameLbl: UILabel!
    @IBOutlet var cityNamelbl: UILabel!
    @IBOutlet var companyNameLbl: UILabel!
    @IBOutlet var websiteLbl: UILabel!
    @IBOutlet var mymapView: MKMapView!
    let manager = CLLocationManager()
    var subdata: apidata?
    var newLocation = (latitude:0.00000,longitude:0.00000)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
            self.dataToPass()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.mymapView.delegate = self
        
    }
    
    func dataToPass(){
        manager.startUpdatingLocation()
        self.nameLbl.text = subdata?.name!
        self.emailLbl.text = subdata?.email
        self.phoneNumberLbl.text = subdata?.phone
        self.idNoInfo.text = "\(subdata?.id! ?? 0)"
        self.cityNamelbl.text = subdata?.address?.city
        self.streetNameLbl.text = subdata?.address?.street
        self.zipcodeLbl.text = subdata?.address?.zipcode
        self.companyNameLbl.text = subdata?.company?.name
        self.websiteLbl.text = subdata?.website
        let lattitudeNew  = Double("\(subdata?.address?.geo?.lat)")
        let longitudeNew = Double("\(subdata?.address?.geo?.lng)")
        newLocation.latitude = lattitudeNew ?? 30.709578
        newLocation.longitude = longitudeNew ?? 76.688673
//print(newLocation)
    }
}
extension subDataViewController: CLLocationManagerDelegate,MKMapViewDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil{
            manager.stopUpdatingLocation()
//            location coordinate
            let coordinate = CLLocationCoordinate2D(latitude: newLocation.latitude, longitude: newLocation.longitude )
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let region = MKCoordinateRegion(center: coordinate , span: span)
            mymapView.setRegion(region, animated: true)
//            mark for the location
            let pin = MKPointAnnotation()
            pin.title = subdata?.name
            pin.coordinate = coordinate
            mymapView.addAnnotation(pin)
        }
    }
}
