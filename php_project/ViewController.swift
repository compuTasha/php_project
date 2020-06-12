//
//  ViewController.swift
//  php_project
//
//  Created by 김미주 on 2020/06/12.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let key = "gm%2BdwQ8JPRsI4UOY0H2GnpG5dFW8G6RuFiPYQ0GGSFW26pySBSKHAvUhwthyUzEdmzjH6qHEQ2vuE%2FbX5RgYMQ%3D%3D"
        let url = "http://apis.data.go.kr/6260000/MedicInstitService&serviceKey=\(key)"
        
        let xmlParser = XMLParser(contentsOf: URL(string: url)!)
        xmlParser!.delegate = self
        xmlParser!.parse()
    }
    
      
}

