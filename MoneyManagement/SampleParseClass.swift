//
//  SampleParseClass.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/29/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import Foundation
import Parse

class Transaction: PFObject, PFSubclassing {
    @NSManaged var name:String!
    @NSManaged var bank:String!
    @NSManaged var userID:String!
    
    static func parseClassName() -> String {
        return "Transaction"
    }
   
}
