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
    
    let encoder = JSONEncoder()
    
    struct hospital: Codable {
        var name: String        // 병원 이름
        var addr: String        // 주소
        var x: Double           // x 좌표
        var y: Double           // y 좌표
        var tel: String         // 전화번호
        var medinst: String     // 의료기관종별명 ex.요양병원, 한방병원
        var sbjects: String      // 진료과목내용 ex. 내과, 가정의학과, 한방내과
    }
    
    @IBOutlet weak var outputtext: UILabel!
    @IBOutlet var calendar: FSCalendar!
    
  
    var memo : Results<HealthMemo>?
    
    @IBAction func insert(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "오늘의 건강을 기록하세요", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "추가하기", style: .default) { (action) in
            let new = HealthMemo()
            new.write = textField.text!
            
            self.save(healthMemo: new)
        }
        alert.addTextField{
            (alertTextField) in
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    let realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 2))

    
    func save(healthMemo: HealthMemo){
        print("save")
        do{
            try realm.write{
                realm.add(healthMemo)
               
                let result =  realm.objects(HealthMemo.self)
                for item in result {
                    print("name= \(item.write)")
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
        // Do any additional setup after loading the view.
    }
    

   // 날짜 선택 시 콜백 메소드
      public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
          let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "YYYY-MM-dd"
         print(dateFormatter.string(from: date))
        

       }
    
       // 날짜 선택 해제 시 콜백 메소드
       public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "YYYY-MM-dd"
           print(dateFormatter.string(from: date))
       }

    
    
    
}


class HealthMemo: Object {
   
    @objc dynamic var year:String = ""
    @objc dynamic var month:String = ""
    @objc dynamic var day:String = ""
    @objc dynamic var write: String = ""
}


