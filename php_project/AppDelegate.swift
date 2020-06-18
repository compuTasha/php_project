//
//  AppDelegate.swift
//  php_project
//
//  Created by 김미주 on 2020/06/12.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

let allHospital = DataLoader().hospitalData
let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var locationManager: CLLocationManager?
    
    var shouldSupportAllOrientation = true
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask{
        if shouldSupportAllOrientation == true{
            return UIInterfaceOrientationMask.all
        }
        
        return UIInterfaceOrientationMask.portrait
    }



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        
        for i in 0..<allHospital.count {
            let insertData = Hospital()
            insertData.name = allHospital[i].BIZPLC_NM
            insertData.address = allHospital[i].REFINE_ROADNM_ADDR
            insertData.latitude = (allHospital[i].REFINE_WGS84_LAT as NSString).doubleValue
            insertData.longitude = (allHospital[i].REFINE_WGS84_LOGT as NSString).doubleValue
            insertData.telephone = allHospital[i].LOCPLC_FACLT_TELNO_DTLS
            insertData.medinst = allHospital[i].MEDINST_ASORTMT_NM
            insertData.subject = allHospital[i].TREAT_SBJECT_CONT_INFO
            
            try! realm.write {
                realm.add(insertData)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
     
    }


}

