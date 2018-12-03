//
//  DetailWorker.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 03/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import Foundation
import CoreData

class DetailWorker
{
    func fetchResultById(_ imdbID: String) -> FilmDetail?
    {
        //We need to create a context from this container
        let managedContext = DataManager().managedObjectContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Films")
        fetchRequest.predicate = NSPredicate(format: "imdbID = %@", imdbID)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            var filmDetail: FilmDetail?
            for data in result as! [NSManagedObject] {
                filmDetail = FilmDetail(data: data)
            }
            managedContext.reset()
            return filmDetail
        } catch {
            managedContext.reset()
            return nil
        }
    }
    
    func saveResult(_ film: FilmDetail) {
        
        DispatchQueue.global(qos: .background).async {
            
            guard let exists: FilmDetail? = self.fetchResultById(film.imdbID) , exists == nil else { return }
            
            let managedContext = DataManager().managedObjectContext
            
            //Now let’s create an entity and new user records.
            let searchedFilmEntity = NSEntityDescription.entity(forEntityName: "Films", in: managedContext)!
            
            let newRow = NSManagedObject(entity: searchedFilmEntity, insertInto: managedContext)
            newRow.setValue(film.Title, forKeyPath:"title_")
            newRow.setValue(film.Year, forKey: "year_")
            newRow.setValue(film.Genre, forKey: "genre_")
            newRow.setValue(film.Director, forKey: "director_")
            newRow.setValue(film.Writer, forKey: "writer_")
            newRow.setValue(film.Actors, forKey: "actors_")
            newRow.setValue(film.Plot, forKey: "plot_")
            newRow.setValue(film.Language, forKey: "language_")
            newRow.setValue(film.Poster, forKey: "poster_")
            newRow.setValue(film.imdbRating, forKey: "imdbRating_")
            newRow.setValue(film.imdbVotes, forKey: "imdbVotes_")
            newRow.setValue(film.imdbID, forKey: "imdbID")
            newRow.setValue(film.Category, forKey: "type_")
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            managedContext.reset()
        }
    }
}
