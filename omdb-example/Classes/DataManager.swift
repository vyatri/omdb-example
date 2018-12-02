//
//  DataManager.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 02/12/18.
//  From https://github.com/AnkurVekariya/CoreDataSwiftDemo/blob/master/CoreDataCRUD/ViewController.swift

import Foundation
import CoreData

class DataManager: NSObject {
    
    var managedObjectContext: NSManagedObjectContext
    
    override init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = Bundle.main.url(forResource: "Model", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        DispatchQueue.global(qos: .background).async {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
             This code uses a file named "DataModel.sqlite" in the application's documents directory.
             */
            let storeURL = docURL.appendingPathComponent("Model.sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }

    func createData(){
        
        //We need to create a context from this container
        let managedContext = DataManager().managedObjectContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "Films", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
//        for i in 1...5 {
//
//            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
//            user.setValue("Ankur\(i)", forKeyPath: "username")
//            user.setValue("ankur\(i)@test.com", forKey: "email")
//            user.setValue("ankur\(i)", forKey: "password")
//        }
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData() {
        
        //We need to create a context from this container
        let managedContext = DataManager().managedObjectContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Films")
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "username") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    func updateData(){
       
        //We need to create a context from this container
        let managedContext = DataManager().managedObjectContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Films")
//        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur1")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
//            objectUpdate.setValue("newName", forKey: "username")
//            objectUpdate.setValue("newmail", forKey: "email")
//            objectUpdate.setValue("newpassword", forKey: "password")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
    func deleteData(){
        
        //We need to create a context from this container
        let managedContext = DataManager().managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Films")
//        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
}
