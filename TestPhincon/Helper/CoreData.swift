//
//  CoreData.swift
//  TestPhincon
//
//  Created by Michael Tanakoman on 30/12/21.
//

import Foundation
import UIKit
import CoreData

class FuncCoreData{
    func save(name: String, dataPokemon: ListPokemon, id: Int){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: "MyPokemon", in: context) else {return}
            
            let newData = NSManagedObject(entity: entity, insertInto: context)
            newData.setValue(name, forKey: "pokemonName")
            newData.setValue(dataPokemon.name, forKey: "pokemonType")
            newData.setValue(dataPokemon.url, forKey: "detailUrl")
            newData.setValue(dataPokemon.urlImage, forKey: "imageUrl")
            newData.setValue(id, forKey: "id")
            do{
                try context.save()
                print("Data Saved")
            }catch{
                print("error in saving data")
            }
        }
    }
    
    func retrieve() -> [SavedPokemon]{
        var myPokemon: [SavedPokemon] = []
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            
            let context = appDelegate.persistentContainer.viewContext
            
            do{
                let results = try context.fetch(NSFetchRequest<MyPokemon>(entityName: "MyPokemon"))
                
                for data in results{
                    myPokemon.append(SavedPokemon(id: Int(data.id), name: data.pokemonName ?? "", type: data.pokemonType ?? "", urlImage: data.imageUrl ?? "", urlDetail: data.detailUrl ?? ""))
                }
            }catch{
                print("error in retrieving data")
            }
        }
        return myPokemon
    }
    
    func delete(id: Int){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<MyPokemon> = MyPokemon.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id ==\(Int64(id))")
            
            do{
                let objects = try context.fetch(fetchRequest)
                for object in objects {
                    context.delete(object)
                }
                try context.save()
            }catch{
                print("error in deleting pokemon")
            }
        }
    }
}
