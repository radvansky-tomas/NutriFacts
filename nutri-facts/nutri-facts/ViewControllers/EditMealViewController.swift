//
//  AddCustomMealViewController.swift
//  nutri-facts
//
//  Created by Tomas Radvansky on 21/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit
import UIFloatLabelTextField
import FCUUID

class EditMealViewController: UIViewController,UITextFieldDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var portionTextField: UITextField!
    
    @IBOutlet weak var energyTextField: UIFloatLabelTextField!
    @IBOutlet weak var carbohydratesTextField: UIFloatLabelTextField!
    @IBOutlet weak var sugarTextField: UIFloatLabelTextField!
    
    @IBOutlet weak var totalFatTextField: UIFloatLabelTextField!
    @IBOutlet weak var saturatedFatTextField: UIFloatLabelTextField!
    @IBOutlet weak var transFatTextField: UIFloatLabelTextField!
    @IBOutlet weak var polyUnsatFatTextField: UIFloatLabelTextField!
    @IBOutlet weak var monoUnsatTextField: UIFloatLabelTextField!
    @IBOutlet weak var cholesterolTextField: UIFloatLabelTextField!
    
    @IBOutlet weak var totalProteinTextField: UIFloatLabelTextField!
    @IBOutlet weak var fibreTextField: UIFloatLabelTextField!
    
    @IBOutlet weak var sodiumTextField: UIFloatLabelTextField!
    @IBOutlet weak var pottasiumTextField: UIFloatLabelTextField!
    
    @IBOutlet weak var saveButton: NutriButton!
    //MARK: Vars
    var selectedMeal:Meal?
    //MARK: View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        //Prepare NavigationBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "CancelBtnClicked:")
        
        if self.selectedMeal == nil
        {
            self.selectedMeal = Meal()
        }
        self.UpdateUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CancelBtnClicked(sender:UIBarButtonItem)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func UpdateUI()
    {
        if let currentMeal:Meal = self.selectedMeal
        {
            self.nameTextField.text = currentMeal.name
            self.portionTextField.text = currentMeal.portion
            
            if currentMeal.energy > -1
            {
                self.energyTextField.text = "\(currentMeal.energy)"
            }
            if currentMeal.carbohydrate > -1
            {
                self.carbohydratesTextField.text = "\(currentMeal.carbohydrate)"
            }
            if currentMeal.sugar > -1
            {
                self.sugarTextField.text = "\(currentMeal.sugar)"
            }
            
            if currentMeal.fat > -1
            {
                self.totalFatTextField.text = "\(currentMeal.fat)"
            }
            if currentMeal.polyUnsaturatedFat > -1
            {
                self.polyUnsatFatTextField.text = "\(currentMeal.polyUnsaturatedFat)"
            }
            if currentMeal.monoUnsaturetedFat > -1
            {
                self.monoUnsatTextField.text = "\(currentMeal.monoUnsaturetedFat)"
            }
            if currentMeal.saturatedFat > -1
            {
                self.saturatedFatTextField.text = "\(currentMeal.saturatedFat)"
            }
            if currentMeal.transFat > -1
            {
                self.transFatTextField.text = "\(currentMeal.transFat)"
            }
            if currentMeal.cholesterol > -1
            {
                self.cholesterolTextField.text = "\(currentMeal.cholesterol)"
            }
            
            if currentMeal.protein > -1
            {
                self.totalProteinTextField.text = "\(currentMeal.protein)"
            }
            if currentMeal.fibre > -1
            {
                self.fibreTextField.text = "\(currentMeal.fibre)"
            }
            
            if currentMeal.potassium > -1
            {
                self.pottasiumTextField.text = "\(currentMeal.potassium)"
            }
            if currentMeal.sodium > -1
            {
                self.sodiumTextField.text = "\(currentMeal.sodium)"
            }
            
        }
    }
    
    @IBAction func SaveBtnClicked(sender: AnyObject) {
        
        Core.sharedInstance.realm.beginWrite()
        self.selectedMeal = Meal() //new instance
        if nameTextField.text.length > 0
        {
            selectedMeal?.name = nameTextField.text
        }
        else
        {
            //show error message
            return
        }
        
        if portionTextField.text.length > 0
        {
            selectedMeal?.portion = portionTextField.text
        }
        else
        {
            //show error message
            return
        }
        
        if self.selectedMeal?._id.componentsSeparatedByString("_").count > 1
        {
            println("SaveBtnClicked - Custom")
        }
        else
        {
            println("SaveBtnClicked - WS")
            //Generate new ID
            if self.selectedMeal?._id.length > 0
            {
                selectedMeal?._id = "tr_".stringByAppendingString(self.selectedMeal!._id)
            }
            else
            {
                //generate UUID
                selectedMeal?._id = "tr_".stringByAppendingString(FCUUID.uuid())
            }
        }
        
        if let convertedDouble:Double = energyTextField.text.toDouble()
        {
            selectedMeal?.energy = convertedDouble
        }
        if let convertedDouble:Double = carbohydratesTextField.text.toDouble()
        {
            selectedMeal?.carbohydrate = convertedDouble
        }
        if let convertedDouble:Double = sugarTextField.text.toDouble()
        {
            selectedMeal?.sugar = convertedDouble
        }
        
        if let convertedDouble:Double = totalFatTextField.text.toDouble()
        {
            selectedMeal?.fat = convertedDouble
        }
        if let convertedDouble:Double = transFatTextField.text.toDouble()
        {
            selectedMeal?.transFat = convertedDouble
        }
        if let convertedDouble:Double = saturatedFatTextField.text.toDouble()
        {
            selectedMeal?.saturatedFat = convertedDouble
        }
        if let convertedDouble:Double = monoUnsatTextField.text.toDouble()
        {
            selectedMeal?.monoUnsaturetedFat = convertedDouble
        }
        if let convertedDouble:Double = polyUnsatFatTextField.text.toDouble()
        {
            selectedMeal?.polyUnsaturatedFat = convertedDouble
        }
        if let convertedDouble:Double = cholesterolTextField.text.toDouble()
        {
            selectedMeal?.cholesterol = convertedDouble
        }
        
        if let convertedDouble:Double = totalProteinTextField.text.toDouble()
        {
            selectedMeal?.protein = convertedDouble
        }
        if let convertedDouble:Double = fibreTextField.text.toDouble()
        {
            selectedMeal?.fibre = convertedDouble
        }
        
        if let convertedDouble:Double = sodiumTextField.text.toDouble()
        {
            selectedMeal?.sodium = convertedDouble
        }
        if let convertedDouble:Double = pottasiumTextField.text.toDouble()
        {
            selectedMeal?.potassium = convertedDouble
        }
        
        Core.sharedInstance.realm.add(self.selectedMeal!, update: true)
        Core.sharedInstance.realm.commitWrite()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: Textfield delegates
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        //To fulfill keypad keyboard purpose
        var result = true
        let prospectiveText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string).stringByReplacingOccurrencesOfString(",", withString: ".", options: nil, range: nil)
        
        if count(string) > 0 {
            let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.,").invertedSet
            let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
            
            
            let scanner = NSScanner(string: prospectiveText)
            let resultingTextIsNumeric = scanner.scanDecimal(nil) && scanner.atEnd
            
            result = replacementStringIsLegal &&
            resultingTextIsNumeric
            
        }
        return result
    }
}
