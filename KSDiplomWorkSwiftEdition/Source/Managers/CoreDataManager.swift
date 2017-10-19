//
//  CoreDataManager.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 5/4/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import Foundation
import MagicalRecord

let expenseFileName = "expense"
let incomeFileName = "income"
let fileType = "plist"

class CoreDataManager {
    
    class  func categories(type:CategoryType) -> Array<Any> {
        let fileName = type == .ExpenceCategory ? expenseFileName : incomeFileName
        
        let inputFile = Bundle.main.path(forResource: fileName, ofType: fileType)!
        
        return NSArray.init(contentsOfFile: inputFile)! as! Array<Any>
    }
    
    
    class func preloadCategories(completionHandler:@escaping (Bool) ->Void) {
        let ExpenseCategories = self.categories(type: .ExpenceCategory)
        var categories = self.categories(type: .IncomeCategory)
        
        categories += ExpenseCategories
        print(categories)
        
        MagicalRecord.save({ (localContext) in
            for inputItem in categories {
                let item = inputItem as! NSDictionary
                
                let category = Category.mr_createEntity(in: localContext)!
                
                let title = item.value(forKey: "title") as? String
                
                category.imageName = item.value(forKey: "imageName") as? String
                category.title = title
                category.transctionType = item.value(forKey: "transactionType") as! int_fast16_t
                category.order = item.value(forKey: "order") as? String
            }
        }) { (didSave, error) in
            if didSave == true {
                UserDefaults.standard.set(true, forKey: "categoriesPreload")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "categoriesPreload"), object: nil)
            }
            completionHandler(didSave)
            
        }
    }
    
    class func getPreloadedCategories(type:CategoryType) -> Array<Any> {
        let categoryType : Int16 = Int16(type .rawValue)
        let preloadedCategories = Category.mr_find(byAttribute: "transctionType", withValue: categoryType, andOrderBy: "order", ascending: true)

        return preloadedCategories!
    }
    
    class func saveAmount(amount: Float, for category: Category) {
    MagicalRecord.save({ (localContext) in
        let transaction = Transaction.mr_createEntity(in: localContext)!
        
        transaction.time = NSDate()
        transaction.amount = Int64(amount)
        transaction.category = category.mr_(in: localContext)
        
        })
    }
    
    
}
