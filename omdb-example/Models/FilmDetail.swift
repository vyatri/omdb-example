//
//  FilmDetail.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 02/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import Foundation
import UIKit

struct FilmDetail: Codable {
    let imdbID: String
    let Title: String
    let Year: String
    let Category: CategoryOption
    let Poster: String
    
    private enum CodingKeys: String, CodingKey {
        case imdbID
        case Title
        case Year
        case Category = "Type"
        case Poster
    }
    
    init(imdbID: String, Title: String, Year: String, Category: CategoryOption, Poster: String) {
        self.imdbID = imdbID
        self.Title = Title
        self.Year = Year
        self.Category = Category
        self.Poster = Poster
    }
}
