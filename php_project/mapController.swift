//
//  mapController.swift
//  php_project
//
//  Created by sujin on 2020/06/13.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapController: UIViewController, MKMapViewDelegate {
    
    //let data = DataLoader().hospitalData
    var latitude: Double = 0    // 디비에서 쿼리해온 위도
    var longitude: Double = 0 // 디비애서 쿼리해온 경도
    var Title : String = ""  //디비에서 쿼리해온 이름
    var subtitle = ""   //디비에서 쿼리해온 번호 or 주소
    
    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    @IBAction func zoomIn(_ sender: Any) {
    
    let userLocation = mapView.userLocation//현재 위치 좌표, 남/북 2000미터 스팬
    
    let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: latitude, longitudinalMeters: longitude)
        mapView.setRegion(region, animated: true)
    }

  
    @IBAction func changeMapType(_ sender: Any) {
    

        if mapView.mapType == MKMapType.standard {
            mapView.mapType = MKMapType.satellite
        }
        else {
            mapView.mapType = MKMapType.standard
        }
        
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//정확도 최고로 설정
        locationManager.requestWhenInUseAuthorization()//위치데이터 추적위해 사용자에게 승인요구
        locationManager.startUpdatingLocation()//위치업데이트 시작
        mapView.showsUserLocation = true//위치 보기

        setAnnotation(latitudeValue: latitude, longitudeValue: longitude, delta: 1, title: Title, subtitile: subtitle)
        // Do any additional setup after loading the view.
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span : Double, title strTitle: String, subtitile strSubtitle:String)
    {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
        mapView.addAnnotation(annotation)
        annotation.title = strTitle//"대구파티마병원" //디비 쿼리 병원 이름
        annotation.subtitle = strSubtitle //"053-940-7114"//디비 쿼리 병원 번호
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            setAnnotation(latitudeValue: latitude, longitudeValue: longitude, delta: 1, title: Title, subtitile: subtitle)
            
        }
        else if sender.selectedSegmentIndex == 1 {
             mapThis(destinationCord: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
          
        }
    }
    
        func mapThis(destinationCord : CLLocationCoordinate2D) {
            let souceCordinate = (mapView.userLocation.coordinate)
            let soucePlaceMark = MKPlacemark(coordinate: souceCordinate)
            let destPlaceMark = MKPlacemark(coordinate: destinationCord)
            
            let sourceItem = MKMapItem(placemark: soucePlaceMark)
            let destItem = MKMapItem(placemark: destPlaceMark)
            
            let destinationRequest = MKDirections.Request()
            destinationRequest.source = sourceItem
            destinationRequest.destination = destItem
            destinationRequest.transportType = .automobile
            destinationRequest.requestsAlternateRoutes = true
            
            let direction = MKDirections(request: destinationRequest)
            direction.calculate { (response, error) in
                guard let response = response else {
                    if let error = error {
                        print("Something is wrong")
                    }
                    return
                }
                
                let route = response.routes[0]
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
   }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
}
