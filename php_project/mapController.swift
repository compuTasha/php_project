//
//  mapController.swift
//  php_project
//
//  Created by sujin on 2020/06/13.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit
import MapKit
class mapController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationinfo1: UILabel!
    @IBOutlet var lblLocationinfo2: UILabel!
  
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLocationinfo1.text = ""
        lblLocationinfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
        // Do any additional setup after loading the view.
    }
    
    func goLocation(latitudeValue : CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double ){
        let pLocaiton = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocaiton, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation  = locations.last
        goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {(placemarks, error) -> Void in
            let pm = placemarks!.first
            let country  = pm!.country
            var address:String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                        address += " "
                        address += pm!.thoroughfare!
            }
            self.lblLocationinfo1.text = "현재 위치"
            self.lblLocationinfo2.text = address
            
            
        })
        locationManager.stopUpdatingLocation()
    }
    
    
    @IBOutlet var sgChangeLocation: UISegmentedControl!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
