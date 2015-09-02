//
//  User.swift
//  nutri-facts
//
//  Created by Tomas Radvansky on 20/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit
import RealmSwift

class User: Object {
    dynamic var userID:Int = 0
    dynamic var gender:Bool = false
    dynamic var age:Int = 0
    dynamic var height:Int = 0
    dynamic var weight:Double = 0.0
    dynamic var desiredWeight:Double = 0.0
    
    override static func primaryKey() -> String? {
        return "userID"
    }
}
