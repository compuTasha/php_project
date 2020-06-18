//
//  PharmacyMap.swift
//  php_project
//
//  Created by sujin on 2020/06/17.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//
 
import UIKit
import MapKit
import CoreLocation

class PharmacyMap: UIViewController, MKMapViewDelegate {
    
    let data = DataLoader().pharmacyData
    let data1 = DataLoader().emergencyData
    
//    var latitude: Double = 0    // 디비에서 쿼리해온 위도
//    var longitude: Double = 0 // 디비애서 쿼리해온 경도
//    var Title : String = ""  //디비에서 쿼리해온 이름
//    var subtitle = ""   //디비에서 쿼리해온 번호 or 주소
    
    let locationManager = CLLocationManager()
    
    @IBOutlet var mapView: MKMapView!
    
    
    @IBAction func zoomIn(_ sender: Any) {
        
        let userLocation = mapView.userLocation//현재 위치 좌표, 남/북 2000미터 스팬
            
        let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
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
            
            let coor = locationManager.location?.coordinate
            let myLocation = CLLocation(latitude: coor!.latitude , longitude: coor!.longitude)
            
            for i in 0..<data.count {
                    let insertData = Pharmacy()
                        insertData.name = data[i].BIZPLC_NM
                        insertData.address = data[i].REFINE_ROADNM_ADDR
                        insertData.latitude = (data[i].REFINE_WGS84_LAT as NSString).doubleValue
                        insertData.longitude = (data[i].REFINE_WGS84_LOGT as NSString).doubleValue
//                    let coor = locationManager.location?.coordinate
//                let myLocation = CLLocation(latitude: coor!.latitude , longitude: coor!.longitude)
                    let pharmacy = CLLocation(latitude: insertData.latitude, longitude: insertData.longitude)
                    let distanceInMeters =  myLocation.distance(from: pharmacy)
                    if(distanceInMeters <= 3000){
                        setAnnotation(latitudeValue: insertData.latitude , longitudeValue: insertData.longitude, delta: 1, title: insertData.name, subtitile: insertData.address)
                    }
            }
            // Do any additional setup after loading the view.
        }
        
        func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span : Double, title strTitle: String, subtitile strSubtitle:String)
        {
            let annotation = MKPointAnnotation()
          
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
            mapView.addAnnotation(annotation)
            annotation.title = strTitle //"대구파티마병원" //디비 쿼리 병원 이름
            annotation.subtitle = strSubtitle //"053-940-7114"//디비 쿼리 병원 번호
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
            mapView.centerCoordinate = userLocation.location!.coordinate
        }
    
    
        @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
            if sender.selectedSegmentIndex == 0{
                mapView.removeAnnotations(mapView.annotations)
                let coor = locationManager.location?.coordinate
                let myLocation = CLLocation(latitude: coor!.latitude , longitude: coor!.longitude)
                    for i in 0..<data.count {
                        let insertData = Pharmacy()
                            insertData.name = data[i].BIZPLC_NM
                            insertData.address = data[i].REFINE_ROADNM_ADDR
                            insertData.latitude = (data[i].REFINE_WGS84_LAT as NSString).doubleValue
                            insertData.longitude = (data[i].REFINE_WGS84_LOGT as NSString).doubleValue
//                        let coor = locationManager.location?.coordinate
//                        let myLocation = CLLocation(latitude: coor!.latitude , longitude: coor!.longitude)
                        let pharmacy = CLLocation(latitude: insertData.latitude, longitude: insertData.longitude)
                        let distanceInMeters =  myLocation.distance(from: pharmacy)
                        if(distanceInMeters <= 3000){
                            setAnnotation(latitudeValue: insertData.latitude , longitudeValue: insertData.longitude, delta: 1, title: insertData.name, subtitile: insertData.address)
                        }
                }
                
            }
            else if sender.selectedSegmentIndex == 1 {
                 mapView.removeAnnotations(mapView.annotations)
                for i in 0..<data1.count {
                        let insertData1 = Emergency()
                            insertData1.name = data1[i].BIZPLC_NM
                            insertData1.address = data1[i].REFINE_ROADNM_ADDR
                            insertData1.latitude = (data1[i].REFINE_WGS84_LAT as NSString).doubleValue
                            insertData1.longitude = (data1[i].REFINE_WGS84_LOGT as NSString).doubleValue

                            setAnnotation(latitudeValue: insertData1.latitude , longitudeValue: insertData1.longitude, delta: 1, title: insertData1.name, subtitile: insertData1.address)
                        }

                }
            }
        }
  
    




