//
//  Emergency.swift
//  php_project
//
//  Created by 김미주 on 2020/06/19.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import Foundation
import RealmSwift

class Emergency: Object {
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var telephone = ""
}
