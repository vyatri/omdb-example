//
//  Film.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 01/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import Foundation
import UIKit

enum CategoryOption : String, Codable {
    case series
    case movie
    case eposide
}

struct Film: Codable {
    let imdbID: String
    let Title: String
    let Year: String
    let Category: CategoryOption
    let Poster: URL?
    
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
        self.Poster = URL(string: Poster)
    }
}

struct FilmList : Codable {
    let Search: [Film]
}
