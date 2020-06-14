//
//  DetailViewController.swift
//  php_project
//
//  Created by minjuKang on 2020/06/14.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    
   // let realm = try! Realm()
    //let realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 2))
    let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test data
        let data = Hospital()
        data.name = "abc"
        data.address = "대구"
        data.telephone = "010-0000-0000"
        data.medinst = "요양병원"
        data.subject = "내과, 가정의학과"
        
        try! realm.write {
            realm.add(data)
        }
        
        let query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text).first
        
        print(query?.subject)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addReviewButton(_ sender: Any) {
        var query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text).first
                
        try! realm.write {
            query?.reviews.append(reviewTextView.text)
        }

        
        query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text).first
    
        print(query?.reviews)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
