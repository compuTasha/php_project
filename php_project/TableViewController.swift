//
//  TableViewController.swift
//  php_project
//
//  Created by 김미주 on 2020/06/13.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit
//import Alamofire
//import SwiftyXMLParser

class TableViewController: UITableViewController, XMLParserDelegate {

     var xmlParser = XMLParser()
     
     var currentElement = ""
     var hospitalItems = [[String : String]]()
     var hospitalItem = [String : String]()
     
     var instit_nm = ""
     var street_nm_ad = ""
     
     func requestData() {
         let key = "gm%2BdwQ8JPRsI4UOY0H2GnpG5dFW8G6RuFiPYQ0GGSFW26pySBSKHAvUhwthyUzEdmzjH6qHEQ2vuE%2FbX5RgYMQ%3D%3D"
         let url = "http://apis.data.go.kr/6260000/MedicInstitService&serviceKey=\(key)"
         
         guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
         
         xmlParser.delegate = self
         xmlParser.parse()
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
         requestData()
     }
     
     public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
     {
         currentElement = elementName
         if (elementName == "item") {
             hospitalItem = [String : String]()
             instit_nm = ""
             street_nm_ad = ""
         }
     }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
         if (elementName == "item") {
             hospitalItem["name"] = instit_nm;
             hospitalItem["address"] = street_nm_ad;
             
             hospitalItems.append(hospitalItem)
         }
     
     }

     public func parser(_ parser: XMLParser, foundCharacters string: String)
     {
         if (currentElement == "contents") {
             street_nm_ad = string
         }
         else if (currentElement == "pubtitle") {
             instit_nm = string
             
         }
         
     }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.hospitalItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = hospitalItems[indexPath.row]["name"]

        return cell
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
