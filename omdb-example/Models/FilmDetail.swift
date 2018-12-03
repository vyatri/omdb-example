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
    let Title: String
    let Year: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Poster: String
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let Type: String
    
    private enum CodingKeys: String, CodingKey {
        case Title
        case Year
        case Genre
        case Director
        case Writer
        case Actors
        case Plot
        case Language
        case Poster
        case imdbRating
        case imdbVotes
        case imdbID
        case Type
    }
    
    init(data: NSManagedObject) {
        self.Title = data.value(forKey: "title_") as! String
        self.Year = data.value(forKey: "year_") as! String
        self.Genre = data.value(forKey: "genre_") as! String
        self.Director = data.value(forKey: "director_") as! String
        self.Writer = data.value(forKey: "writer_") as! String
        self.Actors = data.value(forKey: "actors_") as! String
        self.Plot = data.value(forKey: "plot_") as! String
        self.Language = data.value(forKey: "language_") as! String
        self.Poster = data.value(forKey: "poster_") as! String
        self.imdbRating = data.value(forKey: "imdbRating_") as! String
        self.imdbVotes = data.value(forKey: "imdbVotes_") as! String
        self.imdbID = data.value(forKey: "imdbID") as! String
        self.Type = data.value(forKey: "type_") as! String
    }
}
