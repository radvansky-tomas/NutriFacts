//
//  UserRecords.swift
//  nutri-facts
//
//  Created by Tomas Radvansky on 22/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import FCUUID

class UserRecords: Object {
    dynamic var id:String = FCUUID.uuid()
    dynamic var timestamp:NSDate = NSDate()
    dynamic var meal:Meal? //There should be only MealID, but current WS does not support searching by ID
    dynamic var portion:Double = 1.0
    dynamic var expanded:Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //Expanded property should not be persistent!
    override static func ignoredProperties() -> [String] {
        return ["expanded"]
    }
    
    //Realm swift bug -> we have implement these unnecessary functions
    override init() {
        super.init()
    }
    
    override init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    override init(value: AnyObject) {
        super.init(value: value)
    }
    
    override init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
