//
//  BookMarkManager.swift
//  WeatherApp
//
//  Created by Basant Sarda on 18/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit
import CoreData

class BookMarkManager: NSObject {
    static let sharedInstance = BookMarkManager()

    func fetchAllBookMarks() -> [BookMarkedCity]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BookMarkedCity")
        let managedContext = DatabaseManager.sharedInstance.persistentContainer.viewContext
        var objects = NSArray() as! [NSManagedObject]
        managedContext.performAndWait { () -> Void in
            do {
                objects = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return objects as? [BookMarkedCity]
    }
    
    func bookmarkCity(_ cityName:String, _ latitude:String, _ longitude:String) {
            let managedContext = DatabaseManager.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BookMarkedCity")
        
            let predicate = NSPredicate(format: "cityName == %@ && latitude == %@ && longitude == %@", cityName,latitude, longitude)
            fetchRequest.predicate = predicate
            
            var objects = NSArray() as! [NSManagedObject]
            managedContext.performAndWait { () -> Void in
                do {
                    objects = try managedContext.fetch(fetchRequest)
                    if objects.count > 0 {
                        //object already present, so dont save it again.
                        return
                    } else {
                        DispatchQueue.main.async {
                            let entity = NSEntityDescription.entity(forEntityName: "BookMarkedCity",
                                                                    in: managedContext)!
                            
                            let bookMarkedObj = NSManagedObject(entity: entity,
                                                           insertInto: managedContext) as! BookMarkedCity
                            
                                bookMarkedObj.cityName = cityName
                                bookMarkedObj.latitude = latitude
                                bookMarkedObj.longitude = longitude
                            do {
                                try managedContext.save()
                            } catch let error as NSError {
                                print("Could not save. \(error), \(error.userInfo)")
                            }
                        }
                        
                    }
                    
                } catch let error as NSError {
                    print("Could not fetch. \(error), \(error.userInfo)")
                }
            }
            
        }
    
    func removeCityFromBookmark(_ bookmarkedCity: BookMarkedCity) {
        let managedContext = DatabaseManager.sharedInstance.persistentContainer.viewContext
        managedContext.delete(bookmarkedCity)
        
        /*
        do {
            try managedContext.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
 */
    }
}
