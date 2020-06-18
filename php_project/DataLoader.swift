//
//  DataLoader.swift
//  php_project
//
//  Created by 김미주 on 2020/06/15.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import Foundation

public class DataLoader {
    
    @Published var hospitalData = [HospitalData]()
    @Published var pharmacyData = [PharmacyData]()
    @Published var emergencyData = [EmergencyData]()
    
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
                let dataFromJson = try jsonDecoder.decode([PharmacyData].self, from: data)
                
                // don't add if address is nil
                for i in 0..<dataFromJson.count {
                    if(dataFromJson[i].REFINE_ROADNM_ADDR != "") {
                        self.pharmacyData.append(dataFromJson[i])
                    }
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    // 여기서 내 위치 기준으로 정렬할 수 있을 거 같음, 지금은 이름으로 정렬
    func sort() {
        self.hospitalData = self.hospitalData.sorted(by: { $0.BIZPLC_NM < $1.BIZPLC_NM})
//        self.pharmacyData = self.pharmacyData.sorted(by: { $0.BIZPLC_NM < $1.BIZPLC_NM})
    }
}
