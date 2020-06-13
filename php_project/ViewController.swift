//
//  ViewController.swift
//  php_project
//
//  Created by 김미주 on 2020/06/12.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}



