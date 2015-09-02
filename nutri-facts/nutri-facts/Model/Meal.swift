//
//  Meal.swift
//  nutri-facts
//  Meal parsing from http://test.holmusk.com/food/search?q=foodQuery
//  Created by Tomas Radvansky on 17/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class Meal: Object {
    dynamic var _id:String = ""
    dynamic var name:String = ""
    dynamic var portion:String = ""
    
    dynamic var fat:Double = -1 //in grams
    dynamic var cholesterol:Double = -1 //in mgrams
    dynamic var saturatedFat:Double = -1//in grams
    dynamic var transFat:Double = -1//in grams
    dynamic var monoUnsaturetedFat:Double = -1//in grams
    dynamic var polyUnsaturatedFat:Double = -1//in grams
    
    dynamic var potassium:Double = -1 //in mgrams
    dynamic var sodium:Double = -1 //in mgrams
    
    dynamic var energy:Double = -1 //in kj
    dynamic var carbohydrate:Double = -1 //in grams
    dynamic var sugar:Double = -1 //in grams
    
    dynamic var protein:Double = -1 //in grams
    dynamic var fibre:Double = -1 //in grams
    
    dynamic var expanded:Int = 0
    
    override static func primaryKey() -> String? {
        return "_id"
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
    
    init(json:NSDictionary!)
    {
        super.init()
        self._id = (json.objectForKey("_id") as? String)!
        if let nameString:String = json.objectForKey("name") as? String
        {
            self.name = nameString
        }
        //Get metadata
        if let metaDict:NSDictionary = json.objectForKey("meta") as? NSDictionary
        {
            if let portionString:String = metaDict.objectForKey("portion") as? String
            {
                self.portion = portionString
            }
            if let fatString:String = metaDict.objectForKey("fat") as? String
            {
                var endIndex = advance(fatString.endIndex, -2)
                var newString = fatString.substringToIndex(endIndex)
                self.fat = newString.toDouble()!
            }
            
            if let cholesterolString:String = metaDict.objectForKey("cholesterol") as? String
            {
                var endIndex = advance(cholesterolString.endIndex, -3)
                var newString = cholesterolString.substringToIndex(endIndex)
                self.cholesterol = newString.toDouble()!
            }
            
            if let saturatedFatString:String = metaDict.objectForKey("saturated_fat") as? String
            {
                var endIndex = advance(saturatedFatString.endIndex, -2)
                var newString = saturatedFatString.substringToIndex(endIndex)
                self.saturatedFat = newString.toDouble()!
            }
            
            if let transFatString:String = metaDict.objectForKey("trans_fat") as? String
            {
                var endIndex = advance(transFatString.endIndex, -2)
                var newString = transFatString.substringToIndex(endIndex)
                self.transFat = newString.toDouble()!
            }
            
            if let monosaturatedFatString:String = metaDict.objectForKey("monounsaturated_fat") as? String
            {
                var endIndex = advance(monosaturatedFatString.endIndex, -2)
                var newString = monosaturatedFatString.substringToIndex(endIndex)
                self.monoUnsaturetedFat = newString.toDouble()!
            }
            
            if let polysaturatedFatString:String = metaDict.objectForKey("polyunsaturated_fat") as? String
            {
                var endIndex = advance(polysaturatedFatString.endIndex, -2)
                var newString = polysaturatedFatString.substringToIndex(endIndex)
                self.polyUnsaturatedFat = newString.toDouble()!
            }
            
            
            if let potassiumString:String = metaDict.objectForKey("potassium") as? String
            {
                var endIndex = advance(potassiumString.endIndex, -3)
                var newString = potassiumString.substringToIndex(endIndex)
                self.potassium = newString.toDouble()!
            }
            if let sodiumString:String = metaDict.objectForKey("sodium") as? String
            {
                var endIndex = advance(sodiumString.endIndex, -3)
                var newString = sodiumString.substringToIndex(endIndex)
                self.sodium = newString.toDouble()!
            }
            
            
            if let energyString:String = metaDict.objectForKey("energy") as? String
            {
                var endIndex = energyString.rangeOfString("calories", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil)
                var newString = energyString.substringToIndex(endIndex!.startIndex)
                self.energy = newString.toDouble()!
            }
            if let carbohydrateString:String = metaDict.objectForKey("carbohydrates") as? String
            {
                var endIndex = advance(carbohydrateString.endIndex, -2)
                var newString = carbohydrateString.substringToIndex(endIndex)
                self.carbohydrate = newString.toDouble()!
            }
            if let sugarString:String = metaDict.objectForKey("sugar") as? String
            {
                var endIndex = advance(sugarString.endIndex, -2)
                var newString = sugarString.substringToIndex(endIndex)
                self.sugar = newString.toDouble()!
            }
            
            
            if let proteinString:String = metaDict.objectForKey("protein") as? String
            {
                var endIndex = advance(proteinString.endIndex, -2)
                var newString = proteinString.substringToIndex(endIndex)
                self.protein = newString.toDouble()!
            }
            if let fibreString:String = metaDict.objectForKey("fibre") as? String
            {
                var endIndex = advance(fibreString.endIndex, -2)
                var newString = fibreString.substringToIndex(endIndex)
                self.fibre = newString.toDouble()!
            }
        }
    }
}
