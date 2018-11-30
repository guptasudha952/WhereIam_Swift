//
//  ViewController.swift
//  WhereIam_Swift
//
//  Created by Student 06 on 29/11/18.
//  Copyright © 2018 Student 06. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    let locationManger = CLLocationManager()
    
    @IBAction func clear(_ sender: UIButton) {
        
       
    }
    @IBOutlet weak var mapKit: MKMapView!
    @IBAction func btn1(_ sender: UIButton) {
        
        startDetectingLocation()
    }
    func startDetectingLocation(){
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.delegate = self
        locationManger.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude:CGFloat,longitude:CGFloat
        let currentLocation = locations.last!
        latitude = CGFloat (currentLocation.coordinate.latitude)
        longitude = CGFloat (currentLocation.coordinate.longitude)
        print("latitude=\(latitude) and longitude=\(longitude)")
        
        //for span and region
        let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        
        //view on map
        mapKit.setRegion(region,animated: true)
        
        //set point on location
        let anotation = MKPointAnnotation()
        anotation.coordinate = currentLocation.coordinate
        mapKit.addAnnotation(anotation)
        
        let geo = CLGeocoder()
        geo.reverseGeocodeLocation(currentLocation) { (placeMark, error) in
            if placeMark?.count != nil
            {
                let placeMark = placeMark?.first!
                anotation.title = placeMark?.name
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

