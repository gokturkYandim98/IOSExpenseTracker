//
//  realmDays.swift
//  Expense Tracker
//
//  Created by Mustafa Gokturk Yandim on 26.06.2021.
//

import Foundation
import RealmSwift

class realmTransactions: Object {
    
    @objc dynamic var transactionDate:Date? = nil
    //@objc dynamic var data:HomeCellStruct? = nil
    
}
