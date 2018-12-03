//
//  History.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 01/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import UIKit
import CoreData

class History: NSObject, Codable {

    let keyword: String
    let lastPage: Int
    
    init(keyword: String, lastPage: Int) {
        self.keyword = keyword
        self.lastPage = lastPage
    }
    
    init(data: NSManagedObject) {
        self.keyword = data.value(forKey: "keyword_") as! String
        self.lastPage = Int(data.value(forKey: "lastPage_") as! Int64)
    }
}
