//
//  TableViewController.swift
//  php_project
//
//  Created by 김미주 on 2020/06/13.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit
import RealmSwift


class TableViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var filteredData = [HospitalData]()
    
     override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
        
        //print(data)
        
        filteredData = allHospital
        
//        for i in 0..<data.count {
//            var insertData = Hospital()
//            insertData.name = data[i].BIZPLC_NM
//            insertData.address = data[i].REFINE_ROADNM_ADDR
//            insertData.latitude = (data[i].REFINE_WGS84_LAT as NSString).doubleValue
//            insertData.longitude = (data[i].REFINE_WGS84_LOGT as NSString).doubleValue
//            insertData.telephone = data[i].LOCPLC_FACLT_TELNO_DTLS
//            insertData.medinst = data[i].MEDINST_ASORTMT_NM
//            insertData.subject = data[i].TREAT_SBJECT_CONT_INFO
//
//            try! realm.write {
//                realm.add(insertData)
//            }
//        }
        
        self.tableView.rowHeight = 140

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = searchText.isEmpty ? allHospital : allHospital.filter({(hospital: HospitalData) -> Bool in
            var categoryMatch = hospital.TREAT_SBJECT_CONT_INFO.contains(searchText)
            var stringMatch = hospital.BIZPLC_NM.contains(searchText)
            return categoryMatch || stringMatch
        })

        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredData = allHospital
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalCell", for: indexPath) as! CustomCell
        
        cell.backgroundColor = UIColor.clear
        cell.box.layer.borderWidth = 0.5
        cell.box.layer.cornerRadius = 10
        cell.box.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        cell.box.layer.masksToBounds = false
        cell.box.layer.shadowColor = UIColor.black.cgColor
        cell.box.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell.box.layer.shadowOpacity = 0.07
        cell.box.layer.shadowRadius = 1.5
        cell.nameLabel.text = filteredData[indexPath.row].BIZPLC_NM
        cell.distanceLabel.text = filteredData[indexPath.row].SPECL_AMBLNC_VCNT + "km"
        cell.subjectLabel.text = filteredData[indexPath.row].TREAT_SBJECT_CONT_INFO
        
        // Configure the cell...
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailController = segue.destination as? DetailViewController {
                detailController.hospitalName = self.filteredData[tableView.indexPathForSelectedRow!.row].BIZPLC_NM
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
