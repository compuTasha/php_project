//
//  ViewController.swift
//  php_project
//
//  Created by 김미주 on 2020/06/12.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit
import FSCalendar
import RealmSwift

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource {

    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var calendar: FSCalendar!
   
    @IBOutlet var memoTable: UITableView!
    
  
    var memo : Results<HealthMemo>?
    var dateInfo: String = ""
    public var dateSelected: String = ""
    var printStr: String = ""
    var visit : Array<Int> = []
    var cnt: Int = 0
    
    @IBAction func insert(_ sender: Any) {
        var textField = UITextField()
        
      
        let action = UIAlertAction(title: "추가하기", style: .default) { (action) in
            let new = HealthMemo()
            new.write = textField.text!
            new.date = self.dateSelected

            self.save(healthMemo: new)
            self.memoTable.reloadData()
        }
        
        let alert = UIAlertController(title: "건강 상태를 기록하세요", message: "", preferredStyle: .alert)
        alert.addTextField{
            (alertTextField) in
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
 
    let realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 3))

//    let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

    func save(healthMemo: HealthMemo){
        print("save")
        do{
            try realm.write{
                realm.add(healthMemo)
         
            }
        }catch{
            print("error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appdelegate.shouldSupportAllOrientation = false
        calendar?.allowsMultipleSelection = false
        calendar?.delegate = self
        calendar?.dataSource = self
    }
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
          let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
        cnt = 0
        visit = []
        dateInfo = dateFormatter.string(from: date)
        dateSelected = dateFormatter.string(from: date)
        
        
        print("calendar")
        memoTable.reloadData()
        
       }
    
      public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let result = realm.objects(HealthMemo.self).filter("date = %@", dateSelected)
        return (result.count)
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath)

        let result = realm.objects(HealthMemo.self).filter("date = %@", dateSelected)
        print(result)
        cell.textLabel!.text = result[indexPath.row].write
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete{

            let realm = try! Realm()
            let test = realm.objects(HealthMemo.self).filter("date = %@", dateSelected)
            let result = realm.objects(HealthMemo.self).filter("(date = %@) AND (write = %@)", dateSelected, test[indexPath.row].write).first
            try! realm.write {
                realm.delete(result!)
            }
            
            tableView.deleteRows(at: [indexPath], with: .bottom)
            memoTable.reloadData()
            
        }
    }
    
}

class HealthMemo: Object {

    @objc dynamic var date:String = ""
    @objc dynamic var write: String = ""
}
