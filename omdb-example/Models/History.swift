//
//  History.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 01/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import UIKit

class History: NSObject, Codable {

    let keyword: String
    let lastPage: Int
    let lastImdbID: String
    
    init(keyword: String, lastPage: Int, lastImdbID: String) {
        self.keyword = keyword
        self.lastPage = lastPage
        self.lastImdbID = lastImdbID
    }
}
