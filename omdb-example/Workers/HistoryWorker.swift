//
//  HistoryWorker.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 02/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import Foundation
import CoreData

class HistoryWorker
{
    func getHistoryByKeyword(_ keyword: String) -> History?
    {
        //We need to create a context from this container
        let managedContext = DataManager().managedObjectContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchHistory")
        fetchRequest.predicate = NSPredicate(format: "keyword_ = %@", keyword.lowercased())
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            var history:History?
            for data in result as! [NSManagedObject] {
                history = History(data: data)
            }
            managedContext.reset()
            return history
        } catch {
            managedContext.reset()
            return nil
        }
    }
    
    func saveHistory(_ history: History) {
        
        guard history.keyword.count > 0 else { return }
        
        DispatchQueue.global(qos: .background).async {
            
            //We need to create a context from this container
            let managedContext = DataManager().managedObjectContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchHistory")
            fetchRequest.predicate = NSPredicate(format: "keyword_ = %@", history.keyword)
            var record:NSManagedObject
            do {
                let result = try managedContext.fetch(fetchRequest)
                for data in result as! [NSManagedObject] {
                    record = data
                    record.setValue(Int64(history.lastPage), forKey: "lastPage_")
                    try managedContext.save()
                    managedContext.reset()
                    return // once updated, exit here
                }
            } catch let error as NSError  {
                print("Could not update old data or not exists. \(error), \(error.userInfo)")
            }
            
            // Add new record to db instead
            
            let historyEntity = NSEntityDescription.entity(forEntityName: "SearchHistory", in: managedContext)!
            
            let newRow = NSManagedObject(entity: historyEntity, insertInto: managedContext)
            newRow.setValue(history.keyword.lowercased(), forKeyPath:"keyword_")
            newRow.setValue(Int64(history.lastPage), forKey: "lastPage_")
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            managedContext.reset()
        }
        
    }
}
