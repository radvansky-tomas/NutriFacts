//
//  AddMealViewController.swift
//  nutri-facts
//
//  Created by Tomas Radvansky on 22/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit
import FCUUID

class AddMealViewController: UIViewController,ChartViewDelegate {
    //MARK: IBOutlets
    @IBOutlet weak var unitStepper: UIStepper!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var unitPortionLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    //MARK: Vars
    var selectedMeal:Meal?
    
    //MARK: View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup controllers
        self.unitPortionLabel.text = self.selectedMeal?.portion
        barChartView.delegate = self
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.descriptionText = ""
        barChartView.noDataTextDescription = "You need to provide data for the chart."
        barChartView.highlightEnabled = false
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = true
        
        barChartView.maxVisibleValueCount = 60
        barChartView.pinchZoomEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        
        let xAxis:ChartXAxis = barChartView.xAxis
        
        xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
        xAxis.labelFont = UIFont.systemFontOfSize(9)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.gridLineWidth = 0.3
        xAxis.labelTextColor = UIColor.whiteColor()
        xAxis.setLabelsToSkip(0)
        
        let leftAxis:ChartYAxis = barChartView.leftAxis
        
        leftAxis.labelFont = UIFont.systemFontOfSize(9)
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = true
        leftAxis.gridLineWidth = 3
        leftAxis.labelTextColor = UIColor.whiteColor()
        
        let rightAxis:ChartYAxis = barChartView.rightAxis
        rightAxis.labelFont = UIFont.systemFontOfSize(9)
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawGridLinesEnabled = true
        rightAxis.labelTextColor = UIColor.whiteColor()
        
        barChartView.legend.enabled = false
        self.StepperChanged(self)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Update portion label + change dataset
    @IBAction func StepperChanged(sender: AnyObject) {
        self.unitsLabel.text = String(format: "%d", Int(self.unitStepper.value))
        
        var xVals:Array<String> = Array<String> ()
        var yVals:Array<ChartDataEntry> = Array<ChartDataEntry> ()
        var barColors:Array<UIColor> = Array<UIColor>()
        
        //Detailed view
        if let currentMeal:Meal = self.selectedMeal
        {
            if currentMeal.protein != -1
            {
                xVals.append("Prot")
                yVals.append(BarChartDataEntry(value: Float(currentMeal.protein*self.unitStepper.value), xIndex: xVals.count-1, data:nil))
                barColors.append(ProtBaseColor)
            }
            if currentMeal.fibre != -1
            {
                xVals.append("Fibre")
                yVals.append(BarChartDataEntry(value: Float(currentMeal.fibre*self.unitStepper.value), xIndex: xVals.count-1, data:nil))
                barColors.append(ProtBaseColor)
            }
            if currentMeal.carbohydrate != -1
            {
                xVals.append("Carb")
                yVals.append(BarChartDataEntry(value: Float(currentMeal.carbohydrate*self.unitStepper.value), xIndex: xVals.count-1, data:nil))
                barColors.append(CarbBaseColor)
            }
            if currentMeal.sugar != -1
            {
                xVals.append("Sugar")
                yVals.append(BarChartDataEntry(value: Float(currentMeal.sugar*self.unitStepper.value), xIndex: xVals.count-1, data:nil))
                barColors.append(CarbBaseColor)
            }
            if currentMeal.fat != -1
            {
                xVals.append("Fat")
                yVals.append(BarChartDataEntry(value: Float(currentMeal.fat*self.unitStepper.value), xIndex: xVals.count-1, data:nil))
                barColors.append(FatBaseColor)
            }
            if currentMeal.transFat != -1
            {
                xVals.append("TransFat")
                yVals.append(BarChartDataEntry(value: Float(currentMeal.transFat*self.unitStepper.value), xIndex: xVals.count-1, data:nil))
                barColors.append(FatBaseColor)
            }
            if currentMeal.saturatedFat != -1
            {
                xVals.append("SatFat")
                yVals.append(BarChartDataEntry(value: Float(currentMeal.saturatedFat*self.unitStepper.value), xIndex: xVals.count-1, data:nil))
                barColors.append(FatBaseColor)
            }
            if currentMeal.monoUnsaturetedFat != -1
            {
                xVals.append("MonoFat")
                yVals.append(BarChartDataEntry(value: Float(currentMeal.monoUnsaturetedFat*self.unitStepper.value), xIndex: xVals.count-1, data:nil))
                barColors.append(FatBaseColor)
            }
            if currentMeal.polyUnsaturatedFat != -1
            {
                xVals.append("PolyFat")
                yVals.append(BarChartDataEntry(value: Float(currentMeal.polyUnsaturatedFat*self.unitStepper.value), xIndex: xVals.count-1, data:nil))
                barColors.append(FatBaseColor)
            }
            
            var dataSets:Array<ChartDataSet> = Array<ChartDataSet>()
            
            var set1:BarChartDataSet = BarChartDataSet(yVals: yVals, label: currentMeal.name)
            set1.barSpace = 0.60
            set1.valueTextColor = UIColor.whiteColor()
            set1.colors = barColors
            
            dataSets.append(set1)
            var data:BarChartData = BarChartData(xVals: xVals, dataSets: dataSets)
            data.setValueFont(UIFont.systemFontOfSize(11))
            
            barChartView.data = data;
            barChartView.animate(yAxisDuration: 0.5)
        }
    }
    
    @IBAction func CancelBtnClicked(sender: AnyObject) {
        self.mz_dismissFormSheetControllerAnimated(true, completionHandler: { (controller:MZFormSheetController!) -> Void in
            //
        })
    }
    
    @IBAction func SaveBtnClicked(sender: AnyObject) {
        //Add new UserRecords to realm
        Core.sharedInstance.realm.write { () -> Void in
            let newRecord:UserRecords = UserRecords()
            newRecord.timestamp = NSDate()
            newRecord.id = FCUUID.uuid()
            newRecord.meal = self.selectedMeal!
            newRecord.portion = self.unitStepper.value
            Core.sharedInstance.realm.add(newRecord, update: true)
        }
        self.mz_dismissFormSheetControllerAnimated(true, completionHandler: { (controller:MZFormSheetController!) -> Void in
            
        })
    }
    
    //MARK:ChartView Delegate - Do nothing
    func chartValueNothingSelected(chartView: ChartViewBase) {
        //
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        //
    }
}
