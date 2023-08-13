//
//  CoreDataManager.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation
import CoreData

class CoreDataManager:CoreDataManagerProtocol {
    var PersistantContainer: NSPersistentContainer =  NSPersistentContainer(name: Constants.modelName)

    lazy var managedObjectModel: NSManagedObjectModel = {
            let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
            return managedObjectModel
        }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
            return self.PersistantContainer.newBackgroundContext()
        }()
     
    
    // MARK: - Init
    init() {
        setPersistentContainer()
    }

    
    private func setPersistentContainer() {
        let container = NSPersistentContainer(name: Constants.modelName, managedObjectModel: self.managedObjectModel)
            let description = NSPersistentStoreDescription()
            description.type =  NSSQLiteStoreType            
            container.persistentStoreDescriptions = [description]
        PersistantContainer.viewContext.automaticallyMergesChangesFromParent    = true
        PersistantContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
    }
    
    func getRecordCount(completion: @escaping (Int) -> Void) {
        let fetchRequest: NSFetchRequest<NetworkEntity> = NetworkEntity.fetchRequest()
        backgroundContext.perform { [weak self] in
            guard let self else {return}
            do {
                let recordCount = try self.backgroundContext.count(for: fetchRequest)
                completion(recordCount)
            }catch{
                print("Error fetching record count: \(error)")
                completion(0)
            }
        }
    }
    
    func fetch(completion: (@escaping(Result<[NetworkEntity], Error>) -> Void)) {
        backgroundContext.perform {[weak self] in
            guard let self else {return}
            do {
                let items = try self.backgroundContext.fetch(NetworkEntity.fetchRequest())
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func delete(item: NetworkEntity) {
        backgroundContext.perform {[weak self] in
            guard let self else {return}
            self.backgroundContext.delete(item)
            self.performSaveOpertaionOnBackground()
        }
    }
    
    func performSaveOpertaionOnBackground() {
        backgroundContext.perform {[weak self] in
            guard let self else {return}
            self.performSaveOpertaion()
        }
    }
    
    private func performSaveOpertaion() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
                try PersistantContainer.viewContext.save()
            }
            catch {
                print("Error in save background \(error)")
            }
        }
    }

}
