//
//  DataLoader.swift
//  php_project
//
//  Created by 김미주 on 2020/06/15.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import Foundation
import CoreLocation


public class DataLoader {
    
    @Published var hospitalData = [HospitalData]()
    @Published var pharmacyData = [PharmacyData]()
    @Published var emergencyData = [EmergencyData]()
    
//    var latitude: CLLocationDegrees = 0
//    var longitude: CLLocationDegrees = 0
//    var mylocation: CLLocation {
//        return CLLocation(latitude: self.latitude, longitude: self.longitude)
//    }
//    var lati: Double = 37.2839294
//    var longi: Double = 127.0762599
    let locationManager = CLLocationManager()
    
//    var mylocation = CLLocation(latitude: 37.2839294, longitude: 127.0762599)
    
    init() {
        load()
        sort()
    }
    
    func load() {
        
        if let filehosLocation = Bundle.main.url(forResource: "hospital_data", withExtension: "json") {
            
            // do catch in case of an error
            do {
                let data = try Data(contentsOf: filehosLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([HospitalData].self, from: data)
                
                // don't add if address is nil
                for i in 0..<dataFromJson.count {
                    if(dataFromJson[i].REFINE_ROADNM_ADDR != "") {
                        self.hospitalData.append(dataFromJson[i])
                    }
                }
                
            } catch {
                print(error)
            }
        }
        
        if let filephaLocation = Bundle.main.url(forResource: "pharmacy", withExtension: "json") {
            
            // do catch in case of an error
            do {
                let data = try Data(contentsOf: filephaLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([PharmacyData].self, from: data)
                
                for i in 0..<dataFromJson.count {
                        self.pharmacyData.append(dataFromJson[i])
                }
                
            } catch {
                print(error)
            }
        }
        
        if let filephaLocation = Bundle.main.url(forResource: "emergency_pharmacy", withExtension: "json") {
            
            // do catch in case of an error
            do {
                let data = try Data(contentsOf: filephaLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([EmergencyData].self, from: data)
                
                // don't add if address is nil
                for i in 0..<dataFromJson.count {
                    if(dataFromJson[i].REFINE_ROADNM_ADDR != "") {
                        self.emergencyData.append(dataFromJson[i])
                    }
                }
                
            } catch {
                print(error)
            }
        }
    }
//    
//    func distance(to location: CLLocation) -> CLLocationDistance {
//        return location.distance(from: self.mylocation)
//    }
    
    // 여기서 내 위치 기준으로 정렬할 수 있을 거 같음, 지금은 이름으로 정렬
    func sort() {
//        self.hospitalData = self.hospitalData.sorted(by: { $0.BIZPLC_NM < $1.BIZPLC_NM})
//        self.pharmacyData = self.pharmacyData.sorted(by: { $0.BIZPLC_NM < $1.BIZPLC_NM})
        
        let coor = locationManager.location?.coordinate
        let mylocation = CLLocation(latitude: coor?.latitude ?? 37.2839294 , longitude: coor?.longitude ?? 127.076259)//현재 위치 계산

        for i in 0..<hospitalData.count {
            let lat = (hospitalData[i].REFINE_WGS84_LAT as NSString).doubleValue
//            print(lat)
            let long = (hospitalData[i].REFINE_WGS84_LOGT as NSString).doubleValue
//            print(long)
            let tempLocation = CLLocation(latitude: lat, longitude: long)
//            print(tempLocation)
            let meter = mylocation.distance(from: tempLocation)
//            print(meter)
            hospitalData[i].SPECL_AMBLNC_VCNT = String(format: "%.2f", meter * 0.001)
        }
        
        for i in 0..<hospitalData.count {
            self.hospitalData = self.hospitalData.sorted(by: { $0.SPECL_AMBLNC_VCNT < $1.SPECL_AMBLNC_VCNT})
        }
    }

}
