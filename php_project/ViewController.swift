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

    @IBOutlet weak var outputtext: UILabel!
    @IBOutlet var calendar: FSCalendar!
    
  
    var memo : Results<HealthMemo>?
    var dateInfo: String = ""
    
    @IBAction func insert(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "오늘의 건강을 기록하세요", message: "", preferredStyle: .alert)
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

    
    func save(healthMemo: HealthMemo){
        print("save")
        do{
            try realm.write{
                realm.add(healthMemo)
               
                let result =  realm.objects(HealthMemo.self)
                for item in result {
                    print("name= \(item.write) date = \(item.date)")
                }

            }
        }catch{
            print("error")
        }
        //self.outputtext.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar?.allowsMultipleSelection = false
        calendar?.delegate = self
        calendar?.dataSource = self
  
    }
    

   // 날짜 선택 시 콜백 메소드
      public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
          let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
        dateInfo = dateFormatter.string(from: date)
        print(dateInfo)
        

       }


}


class HealthMemo: Object {
   

    @objc dynamic var date:String = ""
    @objc dynamic var write: String = ""
}
