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

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var outputtext: UILabel!
    
    
  
    var memo : Results<HealthMemo>?
    var dateInfo: String = ""
    var dateSelected: String = ""
    var printStr: String = ""
    
    @IBAction func insert(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "건강 상태를 기록하세요", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "추가하기", style: .default) { (action) in
            let new = HealthMemo()
            new.write = textField.text!
            new.date = self.dateInfo
       

            self.save(healthMemo: new)
        }
        alert.addTextField{
            (alertTextField) in
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
 
    let realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 3))
//
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
        calendar?.allowsMultipleSelection = false
        calendar?.delegate = self
        calendar?.dataSource = self
  
    }
    
      public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
          let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
        
        dateSelected = dateFormatter.string(from: date)
        dateInfo = dateFormatter.string(from: date)
        
        let result =  realm.objects(HealthMemo.self)
        //reviewTable.reloadData()
        
        //print(result)
        outputtext.text = ""
       for item in result {
            
            if dateSelected == item.date{
                 
            
                printStr = item.write
             
                outputtext.text = outputtext.text! + printStr
                print(outputtext.text!)
               
                //print("name= \(item.write) date = \(item.date)")
                
            }
            else{
                //outputtext.text = ""
            }
        }
        //print(dateInfo)
       }
    
}


class HealthMemo: Object {

    @objc dynamic var date:String = ""
    @objc dynamic var write: String = ""
}
