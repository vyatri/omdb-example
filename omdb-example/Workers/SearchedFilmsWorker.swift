//
//  SearchedFilmsWorker.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 02/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import Foundation
import CoreData

class SearchedFilmsWorker
{
    func fetchResultsByKeyword(_ keyword: String) -> [Film]
    {
        //We need to create a context from this container
        let managedContext = DataManager().managedObjectContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchedFilms")
        fetchRequest.predicate = NSPredicate(format: "keyword_ = %@", keyword.lowercased())
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            var films = [Film]()
            for data in result as! [NSManagedObject] {
                films.append(Film(data: data))
            }
            managedContext.reset()
            return films
        } catch {
            managedContext.reset()
            return []
        }
    }
    
    func saveResults(_ films: [Film], keyword: String) {
        
        guard keyword.count > 0 else { return }
        
        DispatchQueue.global(qos: .background).async {
            
            let managedContext = DataManager().managedObjectContext
            
            //Now let’s create an entity and new user records.
            let searchedFilmsEntity = NSEntityDescription.entity(forEntityName: "SearchedFilms", in: managedContext)!
            
            for film in films {
                let newRow = NSManagedObject(entity: searchedFilmsEntity, insertInto: managedContext)
                newRow.setValue(keyword.lowercased(), forKeyPath:"keyword_")
                newRow.setValue(film.imdbID, forKey: "imdbID")
                newRow.setValue(film.Title, forKey: "title_")
                newRow.setValue(film.Year, forKey: "year_")
                newRow.setValue(film.Category.rawValue, forKey: "category_")
                newRow.setValue(film.Poster, forKey: "poster_")
                newRow.setValue(false, forKey: "isDownloaded_")
            }
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            managedContext.reset()
        }
    }
    
    func updateAsDownloaded(_ imdbID: String) {
        
        //We need to create a context from this container
        let managedContext = DataManager().managedObjectContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchedFilms")
        fetchRequest.predicate = NSPredicate(format: "keyword_ = %@", imdbID)
        var record:NSManagedObject
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                record = data
                record.setValue(true, forKey: "isDownloaded_")
                try managedContext.save()
            }
        } catch let error as NSError  {
            print("Could not update old data or not exists. \(error), \(error.userInfo)")
        }
        managedContext.reset()
        
    }
}
