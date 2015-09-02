//
//  ProfileViewController.swift
//  nutri-facts
//
//  Created by Tomas Radvansky on 16/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit
import ASValueTrackingSlider

class ProfileViewController: UIViewController,ASValueTrackingSliderDelegate,ASValueTrackingSliderDataSource {
    
    //MARK: IBOutlets
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var desiredWeightLabel: UILabel!
    @IBOutlet weak var maleBtn: NutriButton!
    @IBOutlet weak var femaleBtn: NutriButton!
    @IBOutlet weak var ageSlider: ASValueTrackingSlider!
    @IBOutlet weak var heightSlider: ASValueTrackingSlider!
    @IBOutlet weak var weightSlider: ASValueTrackingSlider!
    @IBOutlet weak var desiredWeightSlider: ASValueTrackingSlider!
    
    //MARK: Vars
    var currentUser:User!
    
    //MARK: View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        //Prepare Navigation controller
        self.navigationItem.hidesBackButton = true
        
        //Are we editing or creating new user?
        if let firstUser:User = Core.sharedInstance.realm.objects(User).first
        {
            currentUser = firstUser
        }
        else
        {
            //Load default values
            currentUser = User()
            currentUser.height = 180
            currentUser.age = 27
            currentUser.gender = false
            currentUser.weight = 65.0
            currentUser.desiredWeight = 65.0
        }
        
        //Setup custom sliders + Load default values
        ageSlider.minimumValue = 10
        ageSlider.maximumValue = 110
        ageSlider.setMaxFractionDigitsDisplayed(0)
        ageSlider.textColor = UIColor.redColor()
        ageSlider.popUpViewColor = ControlBcgSolidColor
        ageSlider.delegate = self
        ageSlider.dataSource = self
        ageSlider.value = Float(self.currentUser.age)
        
        weightSlider.minimumValue = 0
        weightSlider.maximumValue = 260
        weightSlider.setMaxFractionDigitsDisplayed(0)
        weightSlider.textColor = UIColor.whiteColor()
        weightSlider.delegate = self
        weightSlider.dataSource = self
        weightSlider.value = Float(self.currentUser.weight)
        
        heightSlider.minimumValue = 50
        heightSlider.maximumValue = 230
        heightSlider.setMaxFractionDigitsDisplayed(0)
        heightSlider.textColor = UIColor.redColor()
        heightSlider.popUpViewColor = ControlBcgSolidColor
        heightSlider.delegate = self
        heightSlider.dataSource = self
        heightSlider.value = Float(self.currentUser.height)
        
        desiredWeightSlider.minimumValue = 0
        desiredWeightSlider.maximumValue = 260
        desiredWeightSlider.setMaxFractionDigitsDisplayed(0)
        desiredWeightSlider.textColor = UIColor.whiteColor()
        desiredWeightSlider.delegate = self
        desiredWeightSlider.dataSource = self
        desiredWeightSlider.value = Float(self.currentUser.weight)
        
        //Start writting session to avoid realm error during process
        Core.sharedInstance.realm.beginWrite()
        //Load initial UI
        UpdateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UpdateUI()
    {
        if self.currentUser.gender == true
        {
            genderLabel.text = "Female"
        }
        else
        {
            genderLabel.text = "Male"
        }
        if self.currentUser.gender == true
        {
            maleBtn.backgroundColor = ControlBcgColor
            femaleBtn.backgroundColor = ControlBcgHighlightedColor
        }
        else
        {
            maleBtn.backgroundColor = ControlBcgHighlightedColor
            femaleBtn.backgroundColor = ControlBcgColor
        }
        
        weightSlider.setPopUpViewAnimatedColors(WeightSliderColors, withPositions: self.GetColorPositions()) //slider color based on BMI for better UX
        
        desiredWeightSlider.setPopUpViewAnimatedColors(WeightSliderColors, withPositions: self.GetColorPositions()) //slider color based on BMI for better UX
        
        ageLabel.text = String(format: "%d yrs", self.currentUser.age)
        
        heightLabel.text = String(format: "%d cm", self.currentUser.height)
        
        weightLabel.text = String(format: "%.2f kg", self.currentUser.weight)
        
        desiredWeightLabel.text = String(format: "%.2f kg", self.currentUser.desiredWeight)
    }
    //MARK: IBActions
    @IBAction func LetsStartBtnClicked(sender: AnyObject) {
        // Save changes + move to base controller (->then to Dashboard VC)
        Core.sharedInstance.realm.add(self.currentUser, update: true)
        Core.sharedInstance.realm.commitWrite()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func MaleBtnClicked(button:NutriButton!)
    {
        if self.currentUser.gender == true
        {
            self.currentUser.gender = false
        }
        UpdateUI()
    }
    
    @IBAction func FemaleBtnClicked(button:NutriButton!)
    {
        if self.currentUser.gender == false
        {
            self.currentUser.gender = true
        }
        UpdateUI()
    }
    //MARK: Slider updates
    @IBAction func AgeChanged(slider: ASValueTrackingSlider!)
    {
        self.currentUser.age = Int(slider.value)
        UpdateUI()
    }
    @IBAction func HeightChanged(slider: ASValueTrackingSlider!)
    {
        self.currentUser.height = Int(slider.value)
        UpdateUI()
    }
    @IBAction func WeightChanged(slider: ASValueTrackingSlider!)
    {
        self.currentUser.weight = Double(slider.value)
        weightLabel.text = String(format: "%.2f kg", self.currentUser.weight)
    }
    @IBAction func DesiredWeightChanged(slider: ASValueTrackingSlider!)
    {
        self.currentUser.desiredWeight = Double(slider.value)
        desiredWeightLabel.text = String(format: "%.2f kg", self.currentUser.desiredWeight)
    }
    //MARK: ASValueTrackingSliderDelegate
    func sliderWillDisplayPopUpView(slider: ASValueTrackingSlider!) {
        slider.superview?.bringSubviewToFront(slider)
    }
    
    func slider(slider: ASValueTrackingSlider!, stringForValue value: Float) -> String! {
        //Custom label formatter
        if slider == ageSlider
        {
            return String(format: "%.f yrs", value)
        }
        else if slider == heightSlider
        {
            return String(format: "%.f cm", value)
        }
        else
        {
            return String(format: "%.2f kg", value)
        }
    }
    
    //MARK: Helpers
    func GetColorPositions()->Array<NSNumber>
    {
        //        *Severe Thinness	< 16
        //        Moderate Thinness	16 - 17
        //        Mild Thinness	17 - 18.5
        //        Normal	18.5 - 25
        //        Overweight	25 - 30
        //        Obese Class I	30 - 35
        //        *Obese Class II	35 - 40
        var result:Array<NSNumber> = Array<NSNumber>()
        var kgValue:Float = 0
        result.append(NSNumber(float: kgValue))
        kgValue = Globals.WeightForBMI(self.currentUser.gender, height: Float(self.currentUser.height), BMI: 16.0, age: self.currentUser.age)
        result.append(NSNumber(float: kgValue))
        kgValue = Globals.WeightForBMI(self.currentUser.gender, height: Float(self.currentUser.height), BMI: 18.5, age: self.currentUser.age)
        result.append(NSNumber(float: kgValue))
        kgValue = Globals.WeightForBMI(self.currentUser.gender, height: Float(self.currentUser.height), BMI: 18.5, age: self.currentUser.age)
        result.append(NSNumber(float: kgValue))
        kgValue = Globals.WeightForBMI(self.currentUser.gender, height: Float(self.currentUser.height), BMI: 25.0, age: self.currentUser.age)
        result.append(NSNumber(float: kgValue))
        kgValue = Globals.WeightForBMI(self.currentUser.gender, height: Float(self.currentUser.height), BMI: 35.0, age: self.currentUser.age)
        result.append(NSNumber(float: kgValue))
        kgValue = Globals.WeightForBMI(self.currentUser.gender, height: Float(self.currentUser.height), BMI: 35.5, age: self.currentUser.age)
        result.append(NSNumber(float: kgValue))
        kgValue = Globals.WeightForBMI(self.currentUser.gender, height: Float(self.currentUser.height), BMI: 40, age: self.currentUser.age)
        result.append(NSNumber(float: 260)) //till the end
        return result
        
    }
    
}
