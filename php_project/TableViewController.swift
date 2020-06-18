//
//  TableViewController.swift
//  php_project
//
//  Created by 김미주 on 2020/06/13.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let data = DataLoader().hospitalData
    let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    var filteredData = [HospitalData]()
    
     override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
        
        //print(data)
        
        filteredData = data
        
        for i in 0..<data.count {
            var insertData = Hospital()
            insertData.name = data[i].BIZPLC_NM
            insertData.address = data[i].REFINE_ROADNM_ADDR
            insertData.latitude = (data[i].REFINE_WGS84_LAT as NSString).doubleValue
            insertData.longitude = (data[i].REFINE_WGS84_LOGT as NSString).doubleValue
            insertData.telephone = data[i].LOCPLC_FACLT_TELNO_DTLS
            insertData.medinst = data[i].MEDINST_ASORTMT_NM
            insertData.subject = data[i].TREAT_SBJECT_CONT_INFO
            
            try! realm.write {
                realm.add(insertData)
            }
        }

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter({(hospital: HospitalData) -> Bool in
            return hospital.BIZPLC_NM.contains(searchText)
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
        filteredData = data
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalCell", for: indexPath)
        
        cell.textLabel?.text = filteredData[indexPath.row].BIZPLC_NM
        
        //cell.textLabel?.text = data[indexPath.row].BIZPLC_NM
        // Configure the cell...
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailController = segue.destination as? DetailViewController {
                detailController.realm = self.realm
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
