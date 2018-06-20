//
//  CoreData.swift
//  E-Sign
//
//  Created by Kamesh on 19/06/18.
//  Copyright © 2018 fashionexpress. All rights reserved.
//

import Foundation
import CoreData

func saveSign(image: Data, date: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.insertNewObject(forEntityName: "Images", into: managedContext)
    
    entity.setValue(date, forKey: "dateAdded")
    entity.setValue(image, forKey: "image")
    do {
        try managedContext.save()
        print("Data Saved")
    } catch {
        print("Error")
    }
}
func deleteCoreData(row: Int) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let results = try managedContext.fetch(fetchRequest)
        if results.count > 0 {
            let deleteResult = results[row] as! NSManagedObject
            managedContext.delete(deleteResult)
        }
        print(try managedContext.count(for: fetchRequest))
        try managedContext.save()
    } catch {
        print("Error")
    }
}
func fetchCoreData(completionHandler: @escaping ([Record]) -> ()) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let results = try managedContext.fetch(fetchRequest)
        var records = [Record]()
        if results.count > 0 {
            for result in results as! [NSManagedObject] {
                let record = Record()
                if let image = result.value(forKey: "image") as? Data {
                    record.image = image
                }
                if let date = result.value(forKey: "dateAdded") as? String {
                    record.date = date
                }
                records.append(record)
            }
        }
        completionHandler(records)
    } catch {
        print("Error")
    }
}
