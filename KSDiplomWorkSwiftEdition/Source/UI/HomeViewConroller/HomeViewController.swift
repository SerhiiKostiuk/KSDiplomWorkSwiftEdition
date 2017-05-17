//
//  HomeViewController.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 4/27/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit
import MJCalendar
import NVActivityIndicatorView

class HomeViewController: UIViewController, MJCalendarViewDelegate {

    @IBOutlet weak var calendarView: MJCalendarView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    class func create() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        setUpCalendarConfiguration()
        CoreDataManager.preloadCategories { (didSave) in
//            sleep(3)
            self.activityIndicator.stopAnimating()

        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpCalendarConfiguration() {
        self.calendarView.calendarDelegate = self
        
        // Set displayed period type. Available types: Month, ThreeWeeks, TwoWeeks, OneWeek
        self.calendarView.configuration.periodType = .month
        
        // Set shape of day view. Available types: Circle, Square
        self.calendarView.configuration.dayViewType = .circle
        
        // Set selected day display type. Available types:
        // Border - Only border is colored with selected day color
        // Filled - Entire day view is filled with selected day color
        self.calendarView.configuration.selectedDayType = .border
        
        // Set width of selected day border. Relevant only if selectedDayType = .Border
        self.calendarView.configuration.selectedBorderWidth = 1
        
        // Set day text color
        self.calendarView.configuration.dayTextColor = UIColor.red
        
        // Set day background color
        self.calendarView.configuration.dayBackgroundColor = UIColor.blue
        
        // Set selected day text color
        self.calendarView.configuration.selectedDayTextColor = UIColor.white
        
        // Set selected day background color
        self.calendarView.configuration.selectedDayBackgroundColor = UIColor.gray
        
        // Set other month day text color. Relevant only if periodType = .Month
        self.calendarView.configuration.otherMonthTextColor = UIColor.green
        // Set other month background color. Relevant only if periodType = .Month
        self.calendarView.configuration.otherMonthBackgroundColor = UIColor.brown
        
        // Set week text color
        self.calendarView.configuration.weekLabelTextColor = UIColor.cyan
        // Set start day. Available type: .Monday, Sunday
        self.calendarView.configuration.startDayType = .monday
        
        // Set number of letters presented in the week days label
        self.calendarView.configuration.lettersInWeekDayLabel = .one
        
        // Set day text font
        self.calendarView.configuration.dayTextFont = UIFont.systemFont(ofSize: 12)
        
        //Set week's day name font
        self.calendarView.configuration.weekLabelFont = UIFont.systemFont(ofSize: 12)
        
        //Set day view size. It includes border width if selectedDayType = .Border
        self.calendarView.configuration.dayViewSize = CGSize(width: 24, height: 24)
        
        //Set height of row with week's days
        self.calendarView.configuration.rowHeight = 30
        
        // Set height of week's days names view
        self.calendarView.configuration.weekLabelHeight = 25
        
        // To commit all configuration changes execute reloadView method
        self.calendarView.reloadView()
    }

    
    //MARK: MJCalendarViewDelegate
    func calendar(_ calendarView: MJCalendarView, didChangePeriod periodDate: Date, bySwipe: Bool) {
        // Sets month name according to presented dates
//        self.setTitleWithDate(periodDate)
//        
//        // bySwipe diffrentiate changes made from swipes or select date method
//        if bySwipe {
//            // Scroll to relevant date in tableview
//            self.scrollTableViewToDate(periodDate)
//        }
    }
    
    func calendar(_ calendarView: MJCalendarView, backgroundForDate date: Date) -> UIColor? {
        return UIColor.yellow
    }
    
    func calendar(_ calendarView: MJCalendarView, textColorForDate date: Date) -> UIColor? {
        return UIColor.darkGray
    }
    
    func calendar(_ calendarView: MJCalendarView, didSelectDate date: Date) {
//        self.scrollTableViewToDate(date)
    }
    
    
  

}

