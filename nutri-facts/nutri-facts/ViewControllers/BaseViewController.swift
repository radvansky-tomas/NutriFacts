//
//  BaseViewController.swift
//  nutri-facts
//
//  Created by Tomas Radvansky on 21/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        // User management based on User object persistence
        if Core.sharedInstance.realm.objects(User).count > 0
        {
            self.performSegueWithIdentifier("DashboardSegue", sender: self)
        }
        else
        {
            self.performSegueWithIdentifier("ProfileSegue", sender: self)
        }
    }
    
}
