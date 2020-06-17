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
    
    var latitude: Double = 0    // 디비에서 쿼리해온 위도
    var longitude: Double = 0 // 디비애서 쿼리해온 경도
    var Title : String = ""  //디비에서 쿼리해온 이름
    var subtitle = ""   //디비에서 쿼리해온 번호 or 주소
    
    var locationManager:CLLocationManager!
    
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
       
        
     
//        @IBOutlet var searchText: UITextField!
//
//        @IBOutlet var getdirectionbutton: UIButton!
        

        //var matchingItems: [MKMapItem] = [MKMapItem]()
        
    //    @IBAction func textFieldReturn(_ sender: Any)
    //    {
    //        resignFirstResponder()
    //        mapView.removeAnnotation(mapView.annotations as! MKAnnotation)
    //        self.performSearch()
    //
    //    }
    //
    //    func performSearch()  {
    //         // 배열 값 삭제
    //        matchingItems.removeAll()
    //        let request = MKLocalSearch.Request()
    //        // 텍스트 필드의 값으로 초기화된 MKLocalSearchRequest 인스턴스를 생성
    //        request.naturalLanguageQuery = searchText.text
    //        request.region = mapView.region
    //        // 검색 요청 인스턴스에 대한 참조체로 초기화
    //        let search = MKLocalSearch(request: request)
    //        // MKLocalSearchCompletionHandler 메서드가 호출되면서 검색이 시작
    //        search.start(completionHandler: {(response: MKLocalSearch.Response!, error: Error!) in
    //                   if error != nil {
    //                       print("Error occured in search: \(error.localizedDescription)")
    //                   } else if response.mapItems.count == 0 {
    //                       print("No matches found")
    //                   } else {
    //                       print("Matches found")
    //                       // 일치된 값이 있다면 일치된 위치에 대한 mapItem 인스턴스의 배열을 가지고 mapItem 속성에 접근한다.
    //                       for item in response.mapItems as [MKMapItem] {
    //                           if item.name != nil {
    //                               print("Name = \(item.name!)")
    //                           }
    //                           if item.phoneNumber != nil {
    //                               print("Phone = \(item.phoneNumber!)")
    //                           }
    //
    //                           self.matchingItems.append(item as MKMapItem)
    //                           print("Matching items = \(self.matchingItems.count)")
    //                           // 맵에 표시할 어노테이션 생성
    //                           let annotation = MKPointAnnotation()
    //                           // 위치에 어노테이션을 표시
    //                           annotation.coordinate = item.placemark.coordinate
    //                           annotation.title = item.name
    //                           annotation.subtitle = item.phoneNumber
    //                           self.mapView.addAnnotation(annotation)
    //                       }
    //                   }
    //               })
    //           }

    
        override func viewDidLoad() {
            super.viewDidLoad()
            mapView.delegate = self
            mapView.showsUserLocation = true
            
            for i in 0..<data.count {
                                let insertData = Pharmacy()
                                insertData.name = data[i].BIZPLC_NM
                                insertData.address = data[i].REFINE_ROADNM_ADDR
                                insertData.latitude = (data[i].REFINE_WGS84_LAT as NSString).doubleValue
                                insertData.longitude = (data[i].REFINE_WGS84_LOGT as NSString).doubleValue
            //                    let coor = locationManager.location?.coordinate
                                let myLocation = CLLocation(latitude: 37.401144 , longitude: 127.093328)
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
                for i in 0..<data.count {
                    let insertData = Pharmacy()
                    insertData.name = data[i].BIZPLC_NM
                    insertData.address = data[i].REFINE_ROADNM_ADDR
                    insertData.latitude = (data[i].REFINE_WGS84_LAT as NSString).doubleValue
                    insertData.longitude = (data[i].REFINE_WGS84_LOGT as NSString).doubleValue
//                    let coor = locationManager.location?.coordinate
                    let myLocation = CLLocation(latitude: 37.401144 , longitude: 127.093328)
                    let pharmacy = CLLocation(latitude: insertData.latitude, longitude: insertData.longitude)
                    let distanceInMeters =  myLocation.distance(from: pharmacy)
                    if(distanceInMeters <= 3000){
                    setAnnotation(latitudeValue: insertData.latitude , longitudeValue: insertData.longitude, delta: 1, title: insertData.name, subtitile: insertData.address)
                    }
                }
                
            }
            else if sender.selectedSegmentIndex == 1 {
//                 mapThis(destinationCord: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
              
            }
        }
  
    
    //        @IBAction func getDirectionTapped(_ sender: Any) {
    //            getAddress()
    //        }
    //        func getAddress(){
    //        let geoCoder = CLGeocoder()
    //            geoCoder.geocodeAddressString(searchText.text!){
    //            (placemarks, Error) in
    //              guard let placemarks = placemarks, let location = placemarks.first?.location
    //                  else{
    //                   print("No Location Found")
    //                  return
    //              }
    //                print(location)
    //            }
    //            //애플맵 화난다ㅏㅏㅏㅏ
    //
    //        }
//            func mapThis(destinationCord : CLLocationCoordinate2D) {
//                let souceCordinate = (mapView.userLocation.coordinate)
//                let soucePlaceMark = MKPlacemark(coordinate: souceCordinate)
//                let destPlaceMark = MKPlacemark(coordinate: destinationCord)
//
//                let sourceItem = MKMapItem(placemark: soucePlaceMark)
//                let destItem = MKMapItem(placemark: destPlaceMark)
//
//                let destinationRequest = MKDirections.Request()
//                destinationRequest.source = sourceItem
//                destinationRequest.destination = destItem
//                destinationRequest.transportType = .automobile
//                destinationRequest.requestsAlternateRoutes = true
//
//                let direction = MKDirections(request: destinationRequest)
//                direction.calculate { (response, error) in
//                    guard let response = response else {
//                        if let error = error {
//                            print("Something is wrong")
//                        }
//                        return
//                    }
//
//                    let route = response.routes[0]
//                    self.mapView.addOverlay(route.polyline)
//                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//
//            }
//       }
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
//            render.strokeColor = .blue
//            return render
//        }
    }



