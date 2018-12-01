//
//  Film.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 01/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import Foundation
import UIKit

class Film: NSObject, Codable {
    let imdbID: String
    let Title: String
    let Year: String
    let Category: String
    let Poster: String
    
    init(imdbID: String, Title: String, Year: String, Category: String, Poster: String) {
        self.imdbID = imdbID
        self.Title = Title
        self.Year = Year
        self.Category = Category
        self.Poster = Poster
    }
}
