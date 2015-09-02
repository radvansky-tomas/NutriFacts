//
//  Core.swift
//  nutri-facts
//
//  Created by Tomas Radvansky on 17/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit
import AFNetworking
import RealmSwift

class Core: NSObject {
    var realm:Realm = Realm()
    
    //MARK: Singleton Instance
    class var sharedInstance :Core {
        struct Singleton {
            static let instance = Core()
        }
        return Singleton.instance
    }
    
    //MARK: WS
    func SearchFood(query:String,completionBlock:((response:FoodResponse?, error:NSError?) -> Void)?)
    {
        if let str = query.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let theRequest:NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "http://test.holmusk.com/food/search?q=\(str)")!)
            let operation:AFHTTPRequestOperation = AFHTTPRequestOperation(request: theRequest)
            operation.responseSerializer = AFJSONResponseSerializer()
            operation.setCompletionBlockWithSuccess({ (op:AFHTTPRequestOperation!, sender:AnyObject!) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if completionBlock != nil {
                    let obj:NSArray = op.responseObject as! NSArray
                    let foodResponse:FoodResponse = FoodResponse(FromJson:obj)
                    //Add local storage data
                    let predictateString:String = "name CONTAINS[c] '\(query)'"
                    let result = self.realm.objects(Meal).filter(NSPredicate(format: predictateString))
                    for entry in result
                    {
                        foodResponse.meals.append(entry)
                    }
                    completionBlock!(response:foodResponse, error:nil)
                }
                }, failure: { (op:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    //TODO: Add local storage at least
                    if completionBlock != nil {
                        completionBlock!(response:nil, error:error)
                    }
            })
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            operation.start()
        }
        else
        {
            if completionBlock != nil {
                completionBlock!(response:nil, error:nil)
            }
        }
        
    }
    
    
}
