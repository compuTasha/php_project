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
    
    var hospitalName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = realm.objects(Hospital.self).filter("name = %@", hospitalName).first

        nameLabel.text = query?.name
        addressLabel.text = query?.address
        telLabel.text = query?.telephone
        medinstLabel.text = query?.medinst
        subjectLabel.text = query?.subject
        
//        nameLabel.sizeToFit()
//        addressLabel.sizeToFit()
//        telLabel.sizeToFit()
//        medinstLabel.sizeToFit()
//        subjectLabel.sizeToFit()
//
//        nameLabel.numberOfLines = 0
//        addressLabel.numberOfLines = 0
//        telLabel.numberOfLines = 0
//        medinstLabel.numberOfLines = 0
//        subjectLabel.numberOfLines = 0
    }
    
    @IBAction func addReviewButton(_ sender: Any) {
        var query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text!).first
                
        try! realm.write {
            query?.reviews.append(reviewTextView.text)
        }
        
        query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text!).first
    
        print(query?.reviews)
        
        reviewTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text!).first
        
        return (query?.reviews.count)!
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text!).first
        let review = query?.reviews[indexPath.row]
        cell.textLabel!.text = review
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var query = realm.objects(Hospital.self).filter("address = %@", addressLabel.text!).first

        if segue.identifier == "showMap" {
            if let mapController = segue.destination as? mapController {
                mapController.latitude = query?.latitude as! Double
                mapController.longitude = query?.longitude as! Double
                mapController.Title = query?.name as! String
                mapController.subtitle = query?.address as! String
            }
        }
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
