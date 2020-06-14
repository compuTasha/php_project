//
//  Hospital.swift
//  php_project
//
//  Created by minjuKang on 2020/06/14.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import Foundation
import RealmSwift

class Hospital: Object {
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var xlocation: Double = 0
    @objc dynamic var ylocation: Double = 0
    @objc dynamic var telephone = ""
    @objc dynamic var medinst = ""
    @objc dynamic var subject = ""
    var reviews = List<String>()
}
