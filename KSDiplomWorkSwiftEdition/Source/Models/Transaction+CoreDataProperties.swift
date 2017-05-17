//
//  Transaction+CoreDataProperties.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 4/28/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var time: NSDate?
    @NSManaged public var category: Category?

}
