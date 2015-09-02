//
//  DashboardViewController.swift
//  nutri-facts
//
//  Created by Tomas Radvansky on 17/05/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit
import AMTagListView
import RealmSwift

class DashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MenuViewDelegate,UISearchBarDelegate,ChartViewDelegate,StickyHeaderViewDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainTableBottomConstraint: NSLayoutConstraint!
    
    //MARK: Vars+Constants
    let menu = MenuView()
    var currentResults:Array<Meal> = Array<Meal>()
    var currentHistory:Array<Meal> = Array<Meal>()
    var currentRecords:Array<UserRecords> = Array<UserRecords>()
    
    var dashboardBottomArrow:Bool = true
    var selectedMeal:Meal?
    
    //MARK: View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        //Prepare NavigationController
        self.navigationItem.hidesBackButton = true
        self.searchBarHeight.constant = 0.0
        self.view.layoutIfNeeded()
        //Preload data
        self.ReloadUserRecords()
        //Create Menu - Persei
        menu.delegate = self
        menu.headerDelegate = self //Custom delegate to handle menu apperance
        menu.shouldCloseMenu = false
        //Custom MenuItems loader
        menu.items =
            [
                self.GetMenuItemForIcon(MoonIcons.stats_bars), self.GetMenuItemForIcon(MoonIcons.spoon_knife),  self.GetMenuItemForIcon(MoonIcons.book), self.GetMenuItemForIcon(MoonIcons.cogs)
        ]
        mainTableView.addSubview(menu)
        menu.setRevealed(true, animated: true)
        //Keyboard Handling
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let menuIndex:Int = menu.selectedIndex
        {
            switch menuIndex
            {
            case 0:
                break
            case 1:
                //Move to my meals
                self.menu.selectedIndex = 2
                LoadUI(2)
                break
            case 2:
                self.ReloadMyMeals()
                self.mainTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
                break
            default:
                break
            }
        }
    }
    
    //Remove Keyboard Observers
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditMealSegue"
        {
            let editMealVC:EditMealViewController = segue.destinationViewController as! EditMealViewController
            editMealVC.selectedMeal = self.selectedMeal
        }
    }
    
    //MARK: MenuView + Delegates
    func GetMenuItemForIcon(icon:MoonIcons)->MenuItem
    {
        let defaultMenuIconSize:CGSize = CGSizeMake(256, 256)
        //Generate UIImage from icomoon font
        var item:MenuItem = MenuItem(image: Globals.GetUIImageFromIcoMoon(icon, size: defaultMenuIconSize,highlight: false), highlightedImage: Globals.GetUIImageFromIcoMoon(icon, size: defaultMenuIconSize,highlight: true))
        item.highlightedBackgroundColor = AppBaseColor
        item.backgroundColor = MenuItemBcgColor
        item.shadowColor = UIColor.clearColor()
        return item
    }
    
    func LoadUI(menuIndex:Int)
    {
        switch menuIndex
        {
        case 0:
            self.searchBarHeight.constant = 0.0
            self.searchBar.resignFirstResponder()
            self.navigationItem.title = "Dashboard"
            ReloadUserRecords()
        case 1:
            self.searchBarHeight.constant = 44.0
            self.searchBar.becomeFirstResponder()
            self.navigationItem.title = "Add Food"
        case 2:
            self.searchBarHeight.constant = 0.0
            self.searchBar.resignFirstResponder()
            self.navigationItem.title = "My Meals"
            self.ReloadMyMeals()
        case 3:
            self.searchBarHeight.constant = 0.0
            self.searchBar.resignFirstResponder()
            self.navigationItem.title = "Settings"
        default:
            self.searchBarHeight.constant = 0.0
            self.searchBar.resignFirstResponder()
        }
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
            self.mainTableView.reloadData()
        })
    }
    
    func menu(menu: MenuView, didSelectItemAtIndex index: Int) {
        LoadUI(index)
    }
    
    func stickyHeaderViewDelegateWillShow(header: StickyHeaderView) {
        if let menuIndex:Int = menu.selectedIndex
        {
            if menuIndex == 0
            {
                //Show bottom arrow
                if dashboardBottomArrow == false
                {
                    dashboardBottomArrow = true
                    self.mainTableView.beginUpdates()
                    self.mainTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
                    self.mainTableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
                    self.mainTableView.endUpdates()
                }
            }
        }
    }
    func stickyHeaderViewDidHide(header: StickyHeaderView) {
        //println("stickyHeaderViewDidHide")
    }
    func stickyHeaderViewDidShow(header: StickyHeaderView) {
        //println("stickyHeaderViewDidShow")
    }
    func stickyHeaderViewWillHide(header: StickyHeaderView) {
        if let menuIndex:Int = menu.selectedIndex
        {
            if menuIndex == 0
            {
                //Hide bottom arrow
                if dashboardBottomArrow == true
                {
                    dashboardBottomArrow = false
                    self.mainTableView.beginUpdates()
                    self.mainTableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
                    self.mainTableView.insertSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
                    self.mainTableView.endUpdates()
                }
            }
        }
    }
    
    //MARK: Data loading
    func ReloadMyMeals()
    {
        println("\(NSDate()) - ReloadMyMeals Start")
        let results = Core.sharedInstance.realm.objects(Meal)
        self.currentHistory.removeAll(keepCapacity: false)
        for result in results
        {
            self.currentHistory.append(result)
        }
        println("\(NSDate()) - ReloadMyMeals End")
    }
    
    func ReloadUserRecords()
    {
        println("\(NSDate()) - ReloadUserRecords Start")
        let results = Core.sharedInstance.realm.objects(UserRecords)
        self.currentRecords.removeAll(keepCapacity: false)
        for result in results
        {
            self.currentRecords.append(result)
        }
        println("\(NSDate()) - ReloadUserRecords Start")
    }
    
    //MARK: TableView Delegate+Datasource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let menuIndex:Int = menu.selectedIndex
        {
            if menuIndex == 0
            {
                if self.dashboardBottomArrow
                {
                    return 1
                }
                else
                {
                    return 2
                }
            }
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let menuIndex:Int = menu.selectedIndex
        {
            switch menuIndex
            {
            case 0:
                if section == 0
                {
                    if self.dashboardBottomArrow
                    {
                        return 3 // + animated arrow
                    }
                    else
                    {
                        return 2
                    }
                }
                else
                {
                    return self.currentRecords.count
                }
            case 1:
                return self.currentResults.count + 1 //add new
            case 2:
                return self.currentHistory.count + 1 //add new
            case 3:
                return 1 //only logout button
            default:
                return 0
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentifier:String = ""
        if let menuIndex:Int = menu.selectedIndex
        {
            switch menuIndex
            {
            case 0:
                if indexPath.section == 0
                {
                    switch indexPath.row
                    {
                    case 0:
                        cellIdentifier = "PieChartCell"
                        var PieChartCell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
                        if(PieChartCell == nil)
                        {
                            PieChartCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                        }
                        let titleChartLabel:UILabel = PieChartCell?.viewWithTag(100) as! UILabel
                        
                        let pie1View:PieChartView = PieChartCell?.viewWithTag(101) as! PieChartView
                        let pie2View:PieChartView = PieChartCell?.viewWithTag(102) as! PieChartView
                        let pie3View:PieChartView = PieChartCell?.viewWithTag(103) as! PieChartView
                        
                        pie1View.delegate = self
                        pie1View.legend.enabled = false
                        pie1View.usePercentValuesEnabled = true
                        pie1View.holeTransparent = true
                        pie1View.centerTextFont = UIFont.systemFontOfSize(11)
                        pie1View.holeRadiusPercent = 0
                        pie1View.transparentCircleRadiusPercent = 0
                        pie1View.descriptionText = ""
                        pie1View.drawCenterTextEnabled = false
                        pie1View.drawHoleEnabled = false
                        pie1View.rotationAngle = 0
                        pie1View.rotationEnabled = false
                        pie1View.highlightEnabled = false
                        
                        
                        pie1View.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: ChartEasingOption.EaseOutBack)
                        //TODO: replace static mock data by real user values
                        var xVals:Array<String> = Array<String> ()
                        var yVals:Array<BarChartDataEntry> = Array<BarChartDataEntry> ()
                        xVals.append("Carbs")
                        yVals.append(BarChartDataEntry(value: 0.3, xIndex: 0))
                        xVals.append("Protein")
                        yVals.append(BarChartDataEntry(value: 0.2, xIndex: 1))
                        xVals.append("Fat")
                        yVals.append(BarChartDataEntry(value: 0.5, xIndex: 2))
                        let dataSet:PieChartDataSet = PieChartDataSet(yVals: yVals, label: "Ratio")
                        var pieColors:Array<UIColor> = Array<UIColor>()
                        pieColors.append(UIColor.blueColor())
                        pieColors.append(UIColor.greenColor())
                        pieColors.append(UIColor.redColor())
                        dataSet.colors = pieColors
                        let data1:PieChartData = PieChartData(xVals: xVals, dataSet: dataSet)
                        pie1View.data = data1
                        
                        
                        pie2View.delegate = self
                        pie2View.legend.enabled = false
                        pie2View.usePercentValuesEnabled = true
                        pie2View.holeTransparent = true
                        pie2View.centerTextFont = UIFont.systemFontOfSize(11)
                        pie2View.holeRadiusPercent = 0
                        pie2View.transparentCircleRadiusPercent = 0
                        pie2View.descriptionText = ""
                        pie2View.drawCenterTextEnabled = false
                        pie2View.drawHoleEnabled = false
                        pie2View.rotationAngle = 0
                        pie2View.rotationEnabled = false
                        pie2View.highlightEnabled = false
                        
                        pie2View.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: ChartEasingOption.EaseOutBack)
                        var xVals2:Array<String> = Array<String> ()
                        var yVals2:Array<BarChartDataEntry> = Array<BarChartDataEntry> ()
                        xVals2.append("Pottasium")
                        yVals2.append(BarChartDataEntry(value: 0.3, xIndex: 0))
                        xVals2.append("Sodium")
                        yVals2.append(BarChartDataEntry(value: 0.2, xIndex: 1))
                        let dataSet2:PieChartDataSet = PieChartDataSet(yVals: yVals2, label: "Minerals")
                        var pieColors2:Array<UIColor> = Array<UIColor>()
                        pieColors2.append(UIColor.greenColor())
                        pieColors2.append(UIColor.redColor())
                        dataSet2.colors = pieColors2
                        let data2:PieChartData = PieChartData(xVals: xVals2, dataSet: dataSet2)
                        pie2View.data = data2
                        
                        pie3View.delegate = self
                        pie3View.legend.enabled = false
                        pie3View.usePercentValuesEnabled = true
                        pie3View.holeTransparent = true
                        pie3View.centerTextFont = UIFont.systemFontOfSize(11)
                        pie3View.holeRadiusPercent = 0
                        pie3View.transparentCircleRadiusPercent = 0
                        pie3View.descriptionText = ""
                        pie3View.drawCenterTextEnabled = false
                        pie3View.drawHoleEnabled = false
                        pie3View.rotationAngle = 0
                        pie3View.rotationEnabled = false
                        pie3View.highlightEnabled = false
                        
                        pie3View.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: ChartEasingOption.EaseOutBack)
                        var xVals3:Array<String> = Array<String> ()
                        var yVals3:Array<BarChartDataEntry> = Array<BarChartDataEntry> ()
                        xVals3.append("Used")
                        yVals3.append(BarChartDataEntry(value: 0.3, xIndex: 0))
                        xVals3.append("Available")
                        yVals3.append(BarChartDataEntry(value: 0.5, xIndex: 2))
                        let dataSet3:PieChartDataSet = PieChartDataSet(yVals: yVals3, label: "Calories")
                        var pieColors3:Array<UIColor> = Array<UIColor>()
                        pieColors3.append(UIColor.redColor())
                        pieColors3.append(UIColor.greenColor())
                        dataSet3.colors = pieColors3
                        let data3:PieChartData = PieChartData(xVals: xVals3, dataSet: dataSet3)
                        pie3View.data = data3
                        titleChartLabel.text = "Today"
                        
                        return PieChartCell!
                    case 1:
                        cellIdentifier = "BarChartCell"
                        var BarChartCell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
                        if(BarChartCell == nil)
                        {
                            BarChartCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                        }
                        
                        let barChart:BarChartView = BarChartCell?.viewWithTag(100) as! BarChartView
                        barChart.delegate = self
                        barChart.pinchZoomEnabled = false
                        barChart.doubleTapToZoomEnabled = false
                        barChart.descriptionText = ""
                        barChart.noDataTextDescription = "You need to provide data for the chart."
                        barChart.highlightEnabled = false
                        barChart.drawBarShadowEnabled = false
                        barChart.drawValueAboveBarEnabled = true
                        
                        barChart.maxVisibleValueCount = 60
                        barChart.pinchZoomEnabled = false
                        barChart.drawGridBackgroundEnabled = false
                        
                        let xAxis:ChartXAxis = barChart.xAxis
                        
                        xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
                        xAxis.labelFont = UIFont.systemFontOfSize(11)
                        xAxis.drawAxisLineEnabled = true
                        xAxis.drawGridLinesEnabled = true
                        xAxis.gridLineWidth = 0.3
                        xAxis.labelTextColor = UIColor.whiteColor()
                        
                        let leftAxis:ChartYAxis = barChart.leftAxis
                        
                        leftAxis.labelFont = UIFont.systemFontOfSize(11)
                        leftAxis.drawAxisLineEnabled = true
                        leftAxis.drawGridLinesEnabled = true
                        leftAxis.gridLineWidth = 3
                        leftAxis.labelTextColor = UIColor.whiteColor()
                        
                        let rightAxis:ChartYAxis = barChart.rightAxis
                        rightAxis.labelFont = UIFont.systemFontOfSize(11)
                        rightAxis.drawAxisLineEnabled = true
                        rightAxis.drawGridLinesEnabled = false
                        rightAxis.labelTextColor = UIColor.whiteColor()
                        
                        barChart.legend.enabled = false
                        barChart.animate(yAxisDuration: 1.0)
                        var xVals:Array<String> = Array<String> ()
                        var yVals:Array<ChartDataEntry> = Array<ChartDataEntry> ()
                        var barColors:Array<UIColor> = Array<UIColor>()
                        //TODO: replace static mock data by real user values
                        xVals.append("Mon")
                        yVals.append(BarChartDataEntry(value: Float(10.0), xIndex: xVals.count-1, data:nil))
                        barColors.append(UIColor.whiteColor())
                        xVals.append("Tue")
                        yVals.append(BarChartDataEntry(value: Float(11.0), xIndex: xVals.count-1, data:nil))
                        barColors.append(UIColor.whiteColor())
                        xVals.append("Wed")
                        yVals.append(BarChartDataEntry(value: Float(12.0), xIndex: xVals.count-1, data:nil))
                        barColors.append(UIColor.whiteColor())
                        xVals.append("Thu")
                        yVals.append(BarChartDataEntry(value: Float(9.0), xIndex: xVals.count-1, data:nil))
                        barColors.append(UIColor.whiteColor())
                        xVals.append("Fri")
                        yVals.append(BarChartDataEntry(value: Float(3.0), xIndex: xVals.count-1, data:nil))
                        barColors.append(UIColor.whiteColor())
                        
                        xVals.append("Sat")
                        yVals.append(BarChartDataEntry(value: Float(13.0), xIndex: xVals.count-1, data:nil))
                        barColors.append(UIColor.redColor())
                        xVals.append("Sun")
                        yVals.append(BarChartDataEntry(value: Float(9.0), xIndex: xVals.count-1, data:nil))
                        barColors.append(UIColor.redColor())
                        
                        var dataSets:Array<ChartDataSet> = Array<ChartDataSet>()
                        
                        var set1:BarChartDataSet = BarChartDataSet(yVals: yVals, label: "Current Week")
                        set1.barSpace = 0.35
                        set1.valueTextColor = UIColor.whiteColor()
                        set1.colors = barColors
                        
                        dataSets.append(set1)
                        var data:BarChartData = BarChartData(xVals: xVals, dataSets: dataSets)
                        data.setValueFont(UIFont.systemFontOfSize(11))
                        
                        barChart.data = data;
                        
                        
                        let titleChartLabel:UILabel = BarChartCell?.viewWithTag(101) as! UILabel
                        titleChartLabel.text = "Last Week"
                        
                        return BarChartCell!
                    case 2:
                        //Downarrow
                        cellIdentifier = "DashboardCell"
                        var DashboardCell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
                        if(DashboardCell == nil)
                        {
                            DashboardCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                        }
                        let arrow1:NutriButton = DashboardCell!.viewWithTag(100) as! NutriButton
                        let arrow2:NutriButton = DashboardCell!.viewWithTag(101) as! NutriButton
                        // Create a blank animation using the keyPath "cornerRadius", the property we want to animate
                        let animation1 = CABasicAnimation(keyPath: "position")
                        let animation2 = CABasicAnimation(keyPath: "position")
                        // Set the starting value
                        animation1.fromValue = NSValue(CGPoint: arrow1.center)
                        animation2.fromValue = NSValue(CGPoint: arrow2.center)
                        // Set the completion value
                        animation1.toValue = NSValue(CGPoint: CGPointMake(arrow1.center.x, arrow1.center.y-5))
                        animation2.toValue = NSValue(CGPoint: CGPointMake(arrow2.center.x, arrow2.center.y-5))
                        // How may times should the animation repeat?
                        animation1.repeatCount = 1000
                        animation2.repeatCount = 1000
                        // Finally, add the animation to the layer
                        arrow1.layer.addAnimation(animation1, forKey: "position")
                        arrow2.layer.addAnimation(animation2, forKey: "position")
                        return DashboardCell!
                    default:
                        return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "default")
                    }
                }
                else
                {
                    //Section 2 -> user records
                    cellIdentifier = "FoodCell"
                    var FoodCell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
                    if(FoodCell == nil)
                    {
                        FoodCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                    }
                    
                    let currentRecord:UserRecords = self.currentRecords[indexPath.row]
                    if let currentMeal:Meal = currentRecord.meal
                    {
                        //Mark Custom Meals
                        if currentMeal._id.componentsSeparatedByString("_").count > 1
                        {
                            //Custom
                            FoodCell?.contentView.layer.borderColor = AppBaseColor.CGColor
                            FoodCell?.contentView.layer.borderWidth = 1.0
                            FoodCell?.contentView.layer.cornerRadius = 5.0
                        }
                        else
                        {
                            //WS
                            FoodCell?.contentView.layer.borderColor = UIColor.clearColor().CGColor
                            FoodCell?.contentView.layer.borderWidth = 0.0
                            FoodCell?.contentView.layer.cornerRadius = 0.0
                        }
                        
                        let titleChartLabel:UILabel = FoodCell!.viewWithTag(100) as! UILabel
                        let expandBtn:NutriButton = FoodCell!.viewWithTag(101) as! NutriButton
                        let expandView:UIView = FoodCell!.viewWithTag(200) as UIView!
                        let tagView:AMTagListView = FoodCell!.viewWithTag(300) as! AMTagListView
                        tagView.bounces = false
                        let portionLabel:UILabel = expandView.viewWithTag(201) as! UILabel
                        
                        //Add independent swipe gesture recognizers -> added to separate view (this does not affect ChartViewDelegate)
                        let swipeView:UIView = expandView.viewWithTag(210) as UIView!
                        let leftSwipeGR:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "chartLeftSwipped:")
                        leftSwipeGR.direction = UISwipeGestureRecognizerDirection.Left
                        let rightSwipeGR:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "chartRightSwipped:")
                        rightSwipeGR.direction = UISwipeGestureRecognizerDirection.Right
                        swipeView.gestureRecognizers = [leftSwipeGR,rightSwipeGR]
                        
                        let horizontalChart:HorizontalBarChartView = expandView.viewWithTag(202) as! HorizontalBarChartView
                        let editBtn:NutriButton = FoodCell!.viewWithTag(203) as! NutriButton
                        let addBtn:NutriButton = FoodCell!.viewWithTag(204) as! NutriButton
                        editBtn.addTarget(self, action: "EditBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                        addBtn.addTarget(self, action: "AddBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                        expandBtn.addTarget(self, action: "ExpandBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                        
                        horizontalChart.delegate = self
                        horizontalChart.pinchZoomEnabled = false
                        horizontalChart.doubleTapToZoomEnabled = false
                        horizontalChart.descriptionText = ""
                        horizontalChart.noDataTextDescription = "You need to provide data for the chart."
                        horizontalChart.highlightEnabled = false
                        horizontalChart.drawBarShadowEnabled = false
                        horizontalChart.drawValueAboveBarEnabled = true
                        
                        horizontalChart.maxVisibleValueCount = 60
                        horizontalChart.pinchZoomEnabled = false
                        horizontalChart.drawGridBackgroundEnabled = false
                        
                        let xAxis:ChartXAxis = horizontalChart.xAxis
                        
                        xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
                        xAxis.labelFont = UIFont.systemFontOfSize(11)
                        xAxis.drawAxisLineEnabled = true
                        xAxis.drawGridLinesEnabled = true
                        xAxis.gridLineWidth = 0.3
                        xAxis.labelTextColor = UIColor.whiteColor()
                        
                        let leftAxis:ChartYAxis = horizontalChart.leftAxis
                        
                        leftAxis.labelFont = UIFont.systemFontOfSize(11)
                        leftAxis.drawAxisLineEnabled = true
                        leftAxis.drawGridLinesEnabled = true
                        leftAxis.gridLineWidth = 3
                        leftAxis.labelTextColor = UIColor.whiteColor()
                        
                        let rightAxis:ChartYAxis = horizontalChart.rightAxis
                        rightAxis.labelFont = UIFont.systemFontOfSize(11)
                        rightAxis.drawAxisLineEnabled = true
                        rightAxis.drawGridLinesEnabled = false
                        rightAxis.labelTextColor = UIColor.whiteColor()
                        
                        horizontalChart.legend.enabled = false
                        horizontalChart.animate(yAxisDuration: 1.0)
                        portionLabel.text = "\(currentRecord.portion) x \(currentMeal.portion)"
                        
                        if currentRecord.expanded > 0
                        {
                            expandBtn.icon = Globals.IndexOfMoonIcon(MoonIcons.circle_up)
                            expandView.hidden = false
                            
                            var xVals:Array<String> = Array<String> ()
                            var yVals:Array<ChartDataEntry> = Array<ChartDataEntry> ()
                            var barColors:Array<UIColor> = Array<UIColor>()
                            if currentMeal.expanded == 1
                            {
                                if currentMeal.protein != -1
                                {
                                    xVals.append("Protein")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.protein*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(ProtBaseColor)
                                }
                                if currentMeal.carbohydrate != -1
                                {
                                    xVals.append("Carbohydrate")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.carbohydrate*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(CarbBaseColor)
                                }
                                if currentMeal.fat != -1
                                {
                                    xVals.append("Fat")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.fat*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(FatBaseColor)
                                }
                            }
                            else
                            {
                                //Detailed view
                                if currentMeal.protein != -1
                                {
                                    xVals.append("Protein")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.protein*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(ProtBaseColor)
                                }
                                if currentMeal.fibre != -1
                                {
                                    xVals.append("Fibre")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.fibre*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(ProtBaseColor)
                                }
                                if currentMeal.carbohydrate != -1
                                {
                                    xVals.append("Carbohydrate")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.carbohydrate*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(CarbBaseColor)
                                }
                                if currentMeal.sugar != -1
                                {
                                    xVals.append("Sugar")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.sugar*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(CarbBaseColor)
                                }
                                if currentMeal.fat != -1
                                {
                                    xVals.append("Fat")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.fat*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(FatBaseColor)
                                }
                                if currentMeal.transFat != -1
                                {
                                    xVals.append("TransFat")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.transFat*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(FatBaseColor)
                                }
                                if currentMeal.saturatedFat != -1
                                {
                                    xVals.append("SaturatedFat")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.saturatedFat*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(FatBaseColor)
                                }
                                if currentMeal.monoUnsaturetedFat != -1
                                {
                                    xVals.append("MonoUnsaturetedFat")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.monoUnsaturetedFat*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(FatBaseColor)
                                }
                                if currentMeal.polyUnsaturatedFat != -1
                                {
                                    xVals.append("PolyUnsaturatedFat")
                                    yVals.append(BarChartDataEntry(value: Float(currentMeal.polyUnsaturatedFat*currentRecord.portion), xIndex: xVals.count-1, data:nil))
                                    barColors.append(FatBaseColor)
                                }
                            }
                            
                            var dataSets:Array<ChartDataSet> = Array<ChartDataSet>()
                            
                            var set1:BarChartDataSet = BarChartDataSet(yVals: yVals, label: currentMeal.name)
                            set1.barSpace = 0.35
                            set1.valueTextColor = UIColor.whiteColor()
                            set1.colors = barColors
                            
                            dataSets.append(set1)
                            var data:BarChartData = BarChartData(xVals: xVals, dataSets: dataSets)
                            data.setValueFont(UIFont.systemFontOfSize(11))
                            
                            horizontalChart.data = data;
                            
                        }
                        else
                        {
                            expandBtn.icon = Globals.IndexOfMoonIcon(MoonIcons.circle_down)
                            expandView.hidden = true
                        }
                        
                        titleChartLabel.text = currentMeal.name
                        self.ProcessTagsForMeal(currentMeal, tagListView: tagView)
                    }
                    return FoodCell!
                }
            case 1,
            2:
                var currentMeal:Meal
                
                cellIdentifier = "FoodCell"
                var FoodCell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
                if(FoodCell == nil)
                {
                    FoodCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                }
                
                if menuIndex == 1
                {
                    if indexPath.row >= self.currentResults.count
                    {
                        //settings cell
                        cellIdentifier = "HistoryCell"
                        var HistoryCell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
                        if(HistoryCell == nil)
                        {
                            HistoryCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                        }
                        return HistoryCell!
                    }
                    currentMeal = self.currentResults[indexPath.row]
                    //Mark Custom Meals
                    if currentMeal._id.componentsSeparatedByString("_").count > 1
                    {
                        //Custom
                        FoodCell?.contentView.layer.borderColor = AppBaseColor.CGColor
                        FoodCell?.contentView.layer.borderWidth = 1.0
                        FoodCell?.contentView.layer.cornerRadius = 5.0
                    }
                    else
                    {
                        //WS
                        FoodCell?.contentView.layer.borderColor = UIColor.clearColor().CGColor
                        FoodCell?.contentView.layer.borderWidth = 0.0
                        FoodCell?.contentView.layer.cornerRadius = 0.0
                    }
                }
                else
                {
                    if indexPath.row >= self.currentHistory.count
                    {
                        //settings cell
                        cellIdentifier = "HistoryCell"
                        var HistoryCell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
                        if(HistoryCell == nil)
                        {
                            HistoryCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                        }
                        return HistoryCell!
                    }
                    currentMeal = self.currentHistory[indexPath.row]
                }
                
                let titleChartLabel:UILabel = FoodCell!.viewWithTag(100) as! UILabel
                let expandBtn:NutriButton = FoodCell!.viewWithTag(101) as! NutriButton
                let expandView:UIView = FoodCell!.viewWithTag(200) as UIView!
                let tagView:AMTagListView = FoodCell!.viewWithTag(300) as! AMTagListView
                tagView.bounces = false
                let portionLabel:UILabel = expandView.viewWithTag(201) as! UILabel
                
                //Add independent swipe gesture recognizers -> added to separate view (this does not affect ChartViewDelegate)
                let swipeView:UIView = expandView.viewWithTag(210) as UIView!
                let leftSwipeGR:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "chartLeftSwipped:")
                leftSwipeGR.direction = UISwipeGestureRecognizerDirection.Left
                let rightSwipeGR:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "chartRightSwipped:")
                rightSwipeGR.direction = UISwipeGestureRecognizerDirection.Right
                swipeView.gestureRecognizers = [leftSwipeGR,rightSwipeGR]
                
                let horizontalChart:HorizontalBarChartView = expandView.viewWithTag(202) as! HorizontalBarChartView
                let editBtn:NutriButton = FoodCell!.viewWithTag(203) as! NutriButton
                let addBtn:NutriButton = FoodCell!.viewWithTag(204) as! NutriButton
                editBtn.addTarget(self, action: "EditBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                addBtn.addTarget(self, action: "AddBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                expandBtn.addTarget(self, action: "ExpandBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                
                horizontalChart.delegate = self
                horizontalChart.pinchZoomEnabled = false
                horizontalChart.doubleTapToZoomEnabled = false
                horizontalChart.descriptionText = ""
                horizontalChart.noDataTextDescription = "You need to provide data for the chart."
                horizontalChart.highlightEnabled = false
                horizontalChart.drawBarShadowEnabled = false
                horizontalChart.drawValueAboveBarEnabled = true
                
                horizontalChart.maxVisibleValueCount = 60
                horizontalChart.pinchZoomEnabled = false
                horizontalChart.drawGridBackgroundEnabled = false
                
                let xAxis:ChartXAxis = horizontalChart.xAxis
                
                xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
                xAxis.labelFont = UIFont.systemFontOfSize(11)
                xAxis.drawAxisLineEnabled = true
                xAxis.drawGridLinesEnabled = true
                xAxis.gridLineWidth = 0.3
                xAxis.labelTextColor = UIColor.whiteColor()
                
                let leftAxis:ChartYAxis = horizontalChart.leftAxis
                
                leftAxis.labelFont = UIFont.systemFontOfSize(11)
                leftAxis.drawAxisLineEnabled = true
                leftAxis.drawGridLinesEnabled = true
                leftAxis.gridLineWidth = 3
                leftAxis.labelTextColor = UIColor.whiteColor()
                
                let rightAxis:ChartYAxis = horizontalChart.rightAxis
                rightAxis.labelFont = UIFont.systemFontOfSize(11)
                rightAxis.drawAxisLineEnabled = true
                rightAxis.drawGridLinesEnabled = false
                rightAxis.labelTextColor = UIColor.whiteColor()
                
                horizontalChart.legend.enabled = false
                horizontalChart.animate(yAxisDuration: 1.0)
                portionLabel.text = currentMeal.portion
                
                if currentMeal.expanded > 0
                {
                    expandBtn.icon = Globals.IndexOfMoonIcon(MoonIcons.circle_up)
                    expandView.hidden = false
                    
                    var xVals:Array<String> = Array<String> ()
                    var yVals:Array<ChartDataEntry> = Array<ChartDataEntry> ()
                    var barColors:Array<UIColor> = Array<UIColor>()
                    if currentMeal.expanded == 1
                    {
                        if currentMeal.protein != -1
                        {
                            xVals.append("Protein")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.protein), xIndex: xVals.count-1, data:nil))
                            barColors.append(ProtBaseColor)
                        }
                        if currentMeal.carbohydrate != -1
                        {
                            xVals.append("Carbohydrate")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.carbohydrate), xIndex: xVals.count-1, data:nil))
                            barColors.append(CarbBaseColor)
                        }
                        if currentMeal.fat != -1
                        {
                            xVals.append("Fat")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.fat), xIndex: xVals.count-1, data:nil))
                            barColors.append(FatBaseColor)
                        }
                    }
                    else
                    {
                        //Detailed view
                        if currentMeal.protein != -1
                        {
                            xVals.append("Protein")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.protein), xIndex: xVals.count-1, data:nil))
                            barColors.append(ProtBaseColor)
                        }
                        if currentMeal.fibre != -1
                        {
                            xVals.append("Fibre")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.fibre), xIndex: xVals.count-1, data:nil))
                            barColors.append(ProtBaseColor)
                        }
                        if currentMeal.carbohydrate != -1
                        {
                            xVals.append("Carbohydrate")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.carbohydrate), xIndex: xVals.count-1, data:nil))
                            barColors.append(CarbBaseColor)
                        }
                        if currentMeal.sugar != -1
                        {
                            xVals.append("Sugar")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.sugar), xIndex: xVals.count-1, data:nil))
                            barColors.append(CarbBaseColor)
                        }
                        if currentMeal.fat != -1
                        {
                            xVals.append("Fat")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.fat), xIndex: xVals.count-1, data:nil))
                            barColors.append(FatBaseColor)
                        }
                        if currentMeal.transFat != -1
                        {
                            xVals.append("TransFat")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.transFat), xIndex: xVals.count-1, data:nil))
                            barColors.append(FatBaseColor)
                        }
                        if currentMeal.saturatedFat != -1
                        {
                            xVals.append("SaturatedFat")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.saturatedFat), xIndex: xVals.count-1, data:nil))
                            barColors.append(FatBaseColor)
                        }
                        if currentMeal.monoUnsaturetedFat != -1
                        {
                            xVals.append("MonoUnsaturetedFat")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.monoUnsaturetedFat), xIndex: xVals.count-1, data:nil))
                            barColors.append(FatBaseColor)
                        }
                        if currentMeal.polyUnsaturatedFat != -1
                        {
                            xVals.append("PolyUnsaturatedFat")
                            yVals.append(BarChartDataEntry(value: Float(currentMeal.polyUnsaturatedFat), xIndex: xVals.count-1, data:nil))
                            barColors.append(FatBaseColor)
                        }
                    }
                    
                    var dataSets:Array<ChartDataSet> = Array<ChartDataSet>()
                    
                    var set1:BarChartDataSet = BarChartDataSet(yVals: yVals, label: currentMeal.name)
                    set1.barSpace = 0.35
                    set1.valueTextColor = UIColor.whiteColor()
                    set1.colors = barColors
                    
                    dataSets.append(set1)
                    var data:BarChartData = BarChartData(xVals: xVals, dataSets: dataSets)
                    data.setValueFont(UIFont.systemFontOfSize(11))
                    
                    horizontalChart.data = data;
                    
                }
                else
                {
                    expandBtn.icon = Globals.IndexOfMoonIcon(MoonIcons.circle_down)
                    expandView.hidden = true
                }
                
                titleChartLabel.text = currentMeal.name
                self.ProcessTagsForMeal(currentMeal, tagListView: tagView)
                
                return FoodCell!
                
            case 3:
                //settings cell
                cellIdentifier = "SettingsCell"
                var SettingsCell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
                if(SettingsCell == nil)
                {
                    SettingsCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                }
                return SettingsCell!
            default:
                return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "default")
            }
        }
        return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "default")
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menuIndex:Int = menu.selectedIndex
        {
            switch menuIndex
            {
            case 3:
                //Logout -> delete all data from realm
                Core.sharedInstance.realm.write({ () -> Void in
                    Core.sharedInstance.realm.deleteAll()
                })
                self.navigationController?.popToRootViewControllerAnimated(true)
                break
            default:
                break
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let menuIndex:Int = menu.selectedIndex
        {
            switch menuIndex
            {
            case 0:
                if indexPath.section == 0
                {
                    if indexPath.row == 0
                    {
                        //pie cell
                        return 150
                    }
                    else if indexPath.row == 1
                    {
                        //bar cell
                        return 200
                    }
                    else
                    {
                        //Arrow cell
                        return 80
                    }
                }
                else
                {
                    if indexPath.row < self.currentRecords.count
                    {
                        if self.currentRecords[indexPath.row].expanded == 1
                        {
                            return 300
                        }
                        else if self.currentRecords[indexPath.row].expanded == 2
                        {
                            return 400
                        }
                        else
                        {
                            return 80
                        }
                    }
                    else
                    {
                        return 80
                    }
                }
            case 1:
                if indexPath.row < self.currentResults.count
                {
                    if self.currentResults[indexPath.row].expanded == 1
                    {
                        return 300
                    }
                    else if self.currentResults[indexPath.row].expanded == 2
                    {
                        return 400
                    }
                    else
                    {
                        return 80
                    }
                }
                else
                {
                    return 80
                }
            case 2:
                if indexPath.row < self.currentHistory.count
                {
                    if self.currentHistory[indexPath.row].expanded == 1
                    {
                        return 300
                    }
                    else if self.currentHistory[indexPath.row].expanded == 2
                    {
                        return 400
                    }
                    else
                    {
                        return 80
                    }
                }
                else
                {
                    return 80
                }
            case 3:
                return 60
            default:
                break
            }
        }
        
        return 0
    }
    
    //TODO: create proper method, with values based on user profile
    func ProcessTagsForMeal(currentMeal:Meal, tagListView:AMTagListView)
    {
        tagListView.removeAllTags()
        if currentMeal.sugar == 0
        {
            let sugarTagView:AMTagView = AMTagView()
            sugarTagView.setupWithText("Sugar Free!")
            sugarTagView.tagColor = SugarFreeColor
            tagListView.addTagView(sugarTagView)
        }
        if currentMeal.fat == 0
        {
            let sugarTagView:AMTagView = AMTagView()
            sugarTagView.setupWithText("Fat Free!")
            sugarTagView.tagColor = FatFreeColor
            tagListView.addTagView(sugarTagView)
        }
        else
        {
            var totalFat:Double = 0
            var goodFat:Double = 0
            if currentMeal.fat != -1
            {
                totalFat+=currentMeal.fat
            }
            if currentMeal.monoUnsaturetedFat != -1
            {
                goodFat+=currentMeal.monoUnsaturetedFat
            }
            if currentMeal.polyUnsaturatedFat != -1
            {
                goodFat+=currentMeal.polyUnsaturatedFat
            }
            let percentOfGoodFat = goodFat/totalFat
            if percentOfGoodFat > 0.65 //TODO: find better constant
            {
                let sugarTagView:AMTagView = AMTagView()
                sugarTagView.setupWithText("Essential Oils!")
                sugarTagView.tagColor = OilsColor
                tagListView.addTagView(sugarTagView)
            }
        }
        
        if currentMeal.potassium != -1 && currentMeal.sodium != -1
        {
            let sugarTagView:AMTagView = AMTagView()
            sugarTagView.setupWithText("Minerals!")
            sugarTagView.tagColor = MineralsColor
            tagListView.addTagView(sugarTagView)
            
        }
    }
    
    //MARK: Actions
    func ExpandBtnClicked(button:NutriButton)
    {
        //Expand correct section, first I have to find correct screen -> then check if there is no Add new meal cell
        if let selectedIndex:NSIndexPath = self.mainTableView.indexPathForRowAtPoint(self.mainTableView.convertPoint(button.frame.origin, fromView: button.superview))
        {
            if let menuIndex:Int = menu.selectedIndex
            {
                switch menuIndex
                {
                case 0:
                    if selectedIndex.row < self.currentRecords.count
                    {
                        if self.currentRecords[selectedIndex.row].expanded > 0
                        {
                            self.currentRecords[selectedIndex.row].expanded  = 0
                            self.mainTableView.beginUpdates()
                            self.mainTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Automatic)
                            self.mainTableView.endUpdates()
                            self.mainTableView.scrollToRowAtIndexPath(selectedIndex, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                            
                        }
                        else
                        {
                            //close all other cells
                            var oldIndex:Int = 0
                            for index in 0...self.currentRecords.count-1
                            {
                                if self.currentRecords[index].expanded != 0
                                {
                                    self.currentRecords[index].expanded  = 0
                                    oldIndex = index
                                }
                            }
                            
                            
                            self.currentRecords[selectedIndex.row].expanded  = 1
                            
                            self.mainTableView.beginUpdates()
                            self.mainTableView.reloadRowsAtIndexPaths([selectedIndex,NSIndexPath(forRow: oldIndex, inSection: 1)], withRowAnimation: UITableViewRowAnimation.Automatic)
                            self.mainTableView.endUpdates()
                            self.mainTableView.scrollToRowAtIndexPath(selectedIndex, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                            
                        }
                    }
                    break
                case 1:
                    if selectedIndex.row < self.currentResults.count
                    {
                        self.searchBar.resignFirstResponder()
                        if self.currentResults[selectedIndex.row].expanded > 0
                        {
                            self.currentResults[selectedIndex.row].expanded  = 0
                            self.mainTableView.beginUpdates()
                            self.mainTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Automatic)
                            self.mainTableView.endUpdates()
                            self.mainTableView.scrollToRowAtIndexPath(selectedIndex, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                            
                        }
                        else
                        {
                            //close all other cells
                            var oldIndex:Int = 0
                            for index in 0...self.currentResults.count-1
                            {
                                if self.currentResults[index].expanded != 0
                                {
                                    self.currentResults[index].expanded = 0
                                    oldIndex = index
                                }
                            }
                            
                            self.currentResults[selectedIndex.row].expanded = 1
                            self.mainTableView.beginUpdates()
                            self.mainTableView.reloadRowsAtIndexPaths([selectedIndex,NSIndexPath(forRow: oldIndex, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
                            self.mainTableView.endUpdates()
                            self.mainTableView.scrollToRowAtIndexPath(selectedIndex, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                            
                        }
                    }
                    break
                case 2:
                    if selectedIndex.row < self.currentHistory.count
                    {
                        if self.currentHistory[selectedIndex.row].expanded > 0
                        {
                            self.currentHistory[selectedIndex.row].expanded  = 0
                            self.mainTableView.beginUpdates()
                            self.mainTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Automatic)
                            self.mainTableView.endUpdates()
                            self.mainTableView.scrollToRowAtIndexPath(selectedIndex, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                            
                        }
                        else
                        {
                            //close all other cells
                            var oldIndex:Int = 0
                            for index in 0...self.currentHistory.count-1
                            {
                                if self.currentHistory[index].expanded != 0
                                {
                                    self.currentHistory[index].expanded  = 0
                                    oldIndex = index
                                }
                            }
                            
                            
                            self.currentHistory[selectedIndex.row].expanded  = 1
                            
                            self.mainTableView.beginUpdates()
                            self.mainTableView.reloadRowsAtIndexPaths([selectedIndex,NSIndexPath(forRow: oldIndex, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
                            self.mainTableView.endUpdates()
                            self.mainTableView.scrollToRowAtIndexPath(selectedIndex, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                            
                        }
                    }
                    break
                case 3:
                    break
                default:
                    break
                }
            }
        }
    }
    
    func AddBtnClicked(button:NutriButton)
    {
        //Select meal object from array based on selected screen
        if let selectedIndex:NSIndexPath = self.mainTableView.indexPathForRowAtPoint(self.mainTableView.convertPoint(button.frame.origin, fromView: button.superview))
        {
            if let menuIndex:Int = menu.selectedIndex
            {
                switch menuIndex
                {
                case 0:
                    if selectedIndex.row < self.currentRecords.count
                    {
                        self.selectedMeal = self.currentRecords[selectedIndex.row].meal
                    }
                    else
                    {
                        self.selectedMeal = nil
                    }
                    
                    break
                case 1:
                    if selectedIndex.row < self.currentResults.count
                    {
                        self.selectedMeal = self.currentResults[selectedIndex.row]
                    }
                    else
                    {
                        self.selectedMeal = nil
                    }
                    break
                case 2:
                    if selectedIndex.row < self.currentHistory.count
                    {
                        self.selectedMeal = self.currentHistory[selectedIndex.row]
                    }
                    else
                    {
                        self.selectedMeal = nil
                    }
                    
                    break
                default:
                    break
                }
            }
        }
        
        //Present view controller in form sheet style
        let addMealVC:AddMealViewController = Globals.getViewController("AddMealVC") as! AddMealViewController
        addMealVC.selectedMeal = self.selectedMeal
        let mzVC:MZFormSheetController = MZFormSheetController(size: CGSizeMake(320, 400), viewController: addMealVC)
        mzVC.presentAnimated(true, completionHandler: { (vc:UIViewController!) -> Void in
            //
        })
    }
    
    func EditBtnClicked(button:NutriButton)
    {
        //Select meal object from array based on selected screen
        if let selectedIndex:NSIndexPath = self.mainTableView.indexPathForRowAtPoint(self.mainTableView.convertPoint(button.frame.origin, fromView: button.superview))
        {
            if let menuIndex:Int = menu.selectedIndex
            {
                if let menuIndex:Int = menu.selectedIndex
                {
                    switch menuIndex
                    {
                    case 0:
                        if selectedIndex.row < self.currentRecords.count
                        {
                            self.selectedMeal = self.currentRecords[selectedIndex.row].meal
                        }
                        else
                        {
                            self.selectedMeal = nil
                        }
                        
                        break
                    case 1:
                        if selectedIndex.row < self.currentResults.count
                        {
                            self.selectedMeal = self.currentResults[selectedIndex.row]
                        }
                        else
                        {
                            self.selectedMeal = nil
                        }
                        break
                    case 2:
                        if selectedIndex.row < self.currentHistory.count
                        {
                            self.selectedMeal = self.currentHistory[selectedIndex.row]
                        }
                        else
                        {
                            self.selectedMeal = nil
                        }
                        
                        break
                    default:
                        break
                    }
                }
            }
            
        }
        self.performSegueWithIdentifier("EditMealSegue", sender: self)
    }
    
    //MARK: UISearchbar Delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //Clear table in case of empty string
        if searchText.length == 0
        {
            self.currentResults.removeAll(keepCapacity: false)
            self.mainTableView.reloadData()
            self.menu.setRevealed(true, animated: true)
        }
        else
        {
            self.menu.setRevealed(false, animated: true)
            println("\(NSDate()) - SearchBar Start")
            Core.sharedInstance.SearchFood(searchText, completionBlock: { (response:FoodResponse?, error:NSError?) -> Void in
                if let tmpResponse:FoodResponse = response
                {
                    self.currentResults = tmpResponse.meals
                }
                self.mainTableView.reloadData()
                println("\(NSDate()) - SearchBar End")
            })
        }
    }
    
    //MARK:Chart
    
    @IBAction func chartLeftSwipped(sender: UISwipeGestureRecognizer) {
        self.ToggleChart(sender)
    }
    
    @IBAction func chartRightSwipped(sender: UISwipeGestureRecognizer) {
        self.ToggleChart(sender)
    }
    
    //TODO: page controller + left/right navigation
    func ToggleChart(sender: UISwipeGestureRecognizer)
    {
        if let menuIndex:Int = menu.selectedIndex
        {
            switch menuIndex
            {
            case 0:
                if let selectedIndex:NSIndexPath = self.mainTableView.indexPathForRowAtPoint(sender.locationInView(self.mainTableView))
                {
                    self.mainTableView.reloadData()
                    if self.currentRecords[selectedIndex.row].expanded == 1
                    {
                        //  Core.sharedInstance.realm.write({ () -> Void in
                        self.currentRecords[selectedIndex.row].expanded = 2
                        // })
                        
                        self.mainTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Left)
                    }
                    else
                    {
                        // Core.sharedInstance.realm.write({ () -> Void in
                        self.currentRecords[selectedIndex.row].expanded = 1
                        // })
                        self.mainTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Right)
                    }
                }
                break
            case 1:
                if let selectedIndex:NSIndexPath = self.mainTableView.indexPathForRowAtPoint(sender.locationInView(self.mainTableView))
                {
                    self.mainTableView.reloadData()
                    if self.currentResults[selectedIndex.row].expanded == 1
                    {
                        self.currentResults[selectedIndex.row].expanded = 2
                        self.mainTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Left)
                    }
                    else
                    {
                        self.currentResults[selectedIndex.row].expanded = 1
                        self.mainTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Right)
                    }
                }
                
                break
            case 2:
                if let selectedIndex:NSIndexPath = self.mainTableView.indexPathForRowAtPoint(sender.locationInView(self.mainTableView))
                {
                    self.mainTableView.reloadData()
                    if self.currentHistory[selectedIndex.row].expanded == 1
                    {
                        //  Core.sharedInstance.realm.write({ () -> Void in
                        self.currentHistory[selectedIndex.row].expanded = 2
                        // })
                        
                        self.mainTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Left)
                    }
                    else
                    {
                        // Core.sharedInstance.realm.write({ () -> Void in
                        self.currentHistory[selectedIndex.row].expanded = 1
                        // })
                        self.mainTableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Right)
                    }
                }
                break
            default:
                break
            }
        }
    }
    
    
    //Do nothing -> swipping is handled by separate view + gesture recognizers
    func chartValueNothingSelected(chartView: ChartViewBase) {
        //
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        //
    }
    
    //MARK:Keyboard notifications
    func keyboardWillHide(sender: NSNotification) {
        self.mainTableBottomConstraint.constant = 0.0
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                self.mainTableBottomConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}
