//
//  ViewController.swift
//  php_project
//
//  Created by 김미주 on 2020/06/12.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

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
}

