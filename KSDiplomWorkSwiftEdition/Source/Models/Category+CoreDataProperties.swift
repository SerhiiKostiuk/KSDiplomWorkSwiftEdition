//
//  Category+CoreDataProperties.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 4/28/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import Foundation
import CoreData

enum CategoryType: Int {
    case ExpenceCategory = 1
    case IncomeCategory
}

extension Category {

    @nonobjc public class func categoryFetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var order: String?
    @NSManaged public var title: String?
    @NSManaged public var transctionType: Int16
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension Category {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
