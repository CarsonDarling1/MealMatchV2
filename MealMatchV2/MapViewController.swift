//
//  MapViewController.swift
//  MealMatch
//
//  Created by Carson Darling on 11/9/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var theMap: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    var link = URL(string: "google.com")
    var latVal:Double = 0
    var lonVar:Double = 0
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        searchText.placeholder = "Enter Address or Search Restaurants"
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        showMap(view as Any)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lonVar = Double(locValue.longitude)
        latVal = Double(locValue.latitude)
    }

    @IBAction func showMap(_ sender: Any) {
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            theMap.mapType = MKMapType.standard
        case 1:
            theMap.mapType = MKMapType.satellite
        case 2:
            theMap.mapType = MKMapType.hybrid
        default:
            theMap.mapType = MKMapType.standard
        }
        
        let lon: CLLocationDegrees = lonVar
        let lat: CLLocationDegrees = latVal
        
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
        self.theMap.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "Current Location"
        
        self.theMap.addAnnotation(annotation)
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchText.text!
        request.region = theMap.region
        let search = MKLocalSearch(request: request)
        
        search.start {response, _ in
            guard let response = response else {
                return
            }
            var matchItems:[MKMapItem] = []
            matchItems = response.mapItems
            var address:[String] = []
            print(matchItems)
            self.link = matchItems[0].url ?? URL(string: "google.com")
            for i in 0...matchItems.count - 1{
                print(matchItems[i].name!)
                let selectedItem = matchItems[i].placemark
                address.append ("\(selectedItem.thoroughfare ?? ""), \(selectedItem.locality ?? ""), \(selectedItem.subLocality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.postalCode ?? ""), \(selectedItem.country ?? "")")
            }
            let geoCoder = CLGeocoder();
                    let addressString = address[0]
                    CLGeocoder().geocodeAddressString(addressString, completionHandler:
                        {(placemarks, error) in
                            
                            if error != nil {
                                print("Geocode failed: \(error!.localizedDescription)")
                            } else if placemarks!.count > 0 {
                                let placemark = placemarks![0]
                                let location = placemark.location
                                let coords = location!.coordinate
                                print(location)
                               
                                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                                self.theMap.setRegion(region, animated: true)
                                let ani = MKPointAnnotation()
                                ani.coordinate = placemark.location!.coordinate
                                ani.title = placemark.name
                            self.theMap.addAnnotation(ani)
                        }
                })
            }
    }
    
    @IBAction func webButton(_ sender: Any) {
        UIApplication.shared.open(link!)
    }
}
