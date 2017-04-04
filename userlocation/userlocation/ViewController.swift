//
//  ViewController.swift
//  userlocation
//
//  Created by Student on 3/31/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 0.0, longitude: 0.0)
    var title: String? = "LOL"
    var subtitle: String? = nil
}

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //Map
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var switcher: UISwitch!
    
    let manager = CLLocationManager()
    
    var coordinate: CLLocationCoordinate2D {
        return switcher.isOn ? getOpposite(for: currentLocation) : currentLocation
    }
    
    //var red: MKAnnotationView = {
        //let red = MKAnnotationView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        //red.backgroundColor = .red
        //return red
    //}()
    
    var currentLocation = CLLocationCoordinate2DMake(0.0, 0.0)
    
    func getOpposite(for coordinate: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        if(coordinate.longitude < 0){
            return CLLocationCoordinate2D(latitude: -1 * coordinate.latitude, longitude: coordinate.longitude + 180)
        }
        else {
            return CLLocationCoordinate2D(latitude: -1 * coordinate.latitude, longitude: coordinate.longitude - 180)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        //let span: MKCoordinateSpan = MKCoordinateSpanMake(0.5, 0.5)
        
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        // let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        // map.setRegion(region, animated:true)
        
        currentLocation = myLocation
        
        print(location.coordinate)
        print((-location.coordinate.latitude),(location.coordinate.longitude+180))
        
        self.map.showsUserLocation = true
        self.map.setCenter(coordinate, animated: true)
        
        //if switcher.isOn, let annotation = red.annotation {
            //self.map.removeAnnotation(annotation)
            //annotation.coordinate = coordinate
            //self.map.addAnnotation(annotation)
        //}
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //return red
    //}

}

