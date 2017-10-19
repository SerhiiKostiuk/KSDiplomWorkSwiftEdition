//
//  HomeViewController.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 4/27/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit
import JTAppleCalendar
import NVActivityIndicatorView

class HomeViewController: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var activityBackgroundView: UIView!
    
    let formater = DateFormatter()
    let selectedMonthColor = UIColor.white
    let monthColor = UIColor.black
    let outsideMonthColor = UIColor.lightGray

    class func create() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.bringSubview(toFront: activityBackgroundView)
        
        activityIndicator.startAnimating()
        
        navigationController?.isNavigationBarHidden = true
        
        setupCalendarView()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.selectTransactionOnCalendar),
                                               name: NSNotification.Name(rawValue: "addTransaction"),
                                               object: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "categoriesPreload") == false {
            CoreDataManager.preloadCategories { (didSave) in
                //
                self.activityIndicator.stopAnimating()
            }
        } else {
            activityBackgroundView.removeFromSuperview()
            activityIndicator.stopAnimating()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "categoriesPreload"), object: nil)
        }
    }

    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        let currentDate = Date()
        calendarView.scrollToDate(currentDate,animateScroll: false)
        
        calendarView.selectDates([currentDate], triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: true)
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? CalendarCell else { return }

        if cellState.isSelected {
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
    }

    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? CalendarCell else { return }

        if cellState.isSelected {
            cell.dateLabel.textColor = selectedMonthColor

            let todaysDate = Date()
            if todaysDate == cellState.date
            {
                cell.dateLabel.textColor = UIColor.red
            }
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                cell.dateLabel.textColor = monthColor
            } else {
                cell.dateLabel.textColor = outsideMonthColor
            }
        }
    }
    
    func selectTransactionOnCalendar() {
//       self.calendarView.selectDate(Date())
    }
  
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formater.dateFormat = "yyyy MM dd"
        formater.timeZone = Calendar.current.timeZone
        formater.locale = Calendar.current.locale
        
        let startDate = formater.date(from: "2017 01 01")!
        let endDate = formater.date(from: "2017 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        
        return parameters
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.dateLabel.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        return cell
    }

    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)

        
    }
}

