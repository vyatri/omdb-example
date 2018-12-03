//
//  Film.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 01/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import Foundation
import CoreData

enum CategoryOption : String, Codable {
    case series = "series"
    case movie = "movie"
    case eposide = "episode"
    case game = "game"
}

class Film: NSObject, Codable {
    let imdbID: String
    let Title: String
    let Year: String
    let Category: CategoryOption
    let Poster: String
    var isDownloaded: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case imdbID
        case Title
        case Year
        case Category = "Type"
        case Poster
    }
    
    init(data: NSManagedObject) {
        self.imdbID = data.value(forKey: "imdbID") as! String
        self.Title = data.value(forKey: "title_") as! String
        self.Year = data.value(forKey: "year_") as! String
        self.Category = CategoryOption(rawValue: data.value(forKey: "category_") as! String)!
        self.Poster = data.value(forKey: "poster_") as! String
        self.isDownloaded = data.value(forKey: "isDownloaded_") as! Bool
    }
}

struct FilmList : Codable {
    let Search: [Film]
    
    init(_ films: [Film]) {
        self.Search = films
    }
}
