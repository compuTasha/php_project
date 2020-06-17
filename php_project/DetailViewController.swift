//
//  DetailViewController.swift
//  php_project
//
//  Created by minjuKang on 2020/06/14.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var medinstLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var reviewTable: UITableView!
    
   // let realm = try! Realm()
    var realm = try! Realm()
    //let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    var hospitalName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var query = realm.objects(Hospital.self).filter("name = %@", hospitalName).first

        print("name", hospitalName)
        nameLabel.text = query?.name
        addressLabel.text = query?.address
        telLabel.text = query?.telephone
        medinstLabel.text = query?.medinst
        subjectLabel.text = query?.subject

    }
    
    @IBAction func addReviewButton(_ sender: Any) {
        var query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text).first
                
        try! realm.write {
            query?.reviews.append(reviewTextView.text)
        }

        
        query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text).first
    
        print(query?.reviews)
        
        reviewTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text).first
        
        return (query?.reviews.count)!
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text).first
        let review = query?.reviews[indexPath.row]
        cell.textLabel!.text = review
        return cell
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
