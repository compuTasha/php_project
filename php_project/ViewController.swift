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
   // let dateSelected = HealthMemo()

    func save(healthMemo: HealthMemo){
        print("save")
        do{
            try realm.write{
                realm.add(healthMemo)
               
//                let result =  realm.objects(HealthMemo.self)
//               print(result)
                
//                for item in result {
//                    if dateSelected == item.date{
//                        print("name= \(item.write) date = \(item.date)")
//                    }
//                }
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
        print(result)
        
        for item in result {
            if dateSelected == item.date{
                
               printStr = item.write
             
                outputtext.text = outputtext.text! + printStr
                print(outputtext.text!)
                print("name= \(item.write) date = \(item.date)")
                
            }
        }
        //print(dateInfo)
       }
    
/*
     내가 하고 싶은거:
     DB에 저장된 date랑 dateSelected 값이 똑같으면 그때 db의 date가 같은 write만 출력하기, 그리고 스토리보드 라벨에 보여주기
     */
}


class HealthMemo: Object {

    @objc dynamic var date:String = ""
    @objc dynamic var write: String = ""
}
