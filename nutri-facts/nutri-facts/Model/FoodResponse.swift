//
//  FoodResponse.swift
//  nutri-facts
//  WS response - http://test.holmusk.com/food/search?q=foodQuery
//  Created by Tomas Radvansky on 17/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit

class FoodResponse: NSObject {
    var meals:Array<Meal> = Array<Meal>()
    
    init(FromJson food:NSArray!)
    {
        super.init()
        for entry in food
        {
            //JSON Parsing
            let entryDict:NSDictionary = entry as! NSDictionary
            meals.append(Meal(json: entryDict))
        }
    }
}
