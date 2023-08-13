//
//  CoreDataManager.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
   static let Shared = CoreDataManager()
    var persistentContainer = NSPersistentContainer(name: Constants.modelName)
    var customViewContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
     
    
    // MARK: - Init
    init() {
        setPersistentContainer()
    }

    
    private func setPersistentContainer() {
        let persistentCoordinator = persistentContainer.persistentStoreCoordinator
        let description     = persistentContainer.persistentStoreDescriptions.first
        description?.type   = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        let viewContext                                     = persistentContainer.viewContext
        //viewContext.automaticallyMergesChangesFromParent    = true
        customViewContext.mergePolicy                       = NSMergeByPropertyObjectTrumpMergePolicy
        customViewContext.parent                            = viewContext
    }
    
    func getRecordCount(completion: @escaping (Int) -> Void) {
        let fetchRequest: NSFetchRequest<NetworkEntity> = NetworkEntity.fetchRequest()
        customViewContext.performAndWait {
            do {
                let recordCount = try customViewContext.count(for: fetchRequest)
                completion(recordCount)
            }catch{
                print("Error fetching record count: \(error)")
                completion(0)
            }
        }
    }
    
    func fetch(completion: ((Result<[NetworkEntity], Error>) -> Void)) {
        customViewContext.performAndWait {
            do {
                let items = try customViewContext.fetch(NetworkEntity.fetchRequest())
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func delete(item: NetworkEntity) {
        customViewContext.performAndWait {
            customViewContext.delete(item)
                performSaveOpertaionOnBackground()
        }
    }
    
    func performSaveOpertaionOnBackground() {
        customViewContext.performAndWait {
            performSaveOpertaion()
        }
    }
    
    private func performSaveOpertaion() {
        if customViewContext.hasChanges {
            do {
                try customViewContext.save()
                try persistentContainer.viewContext.save()
            }
            catch {
                print("Error in save background \(error)")
            }
        }
    }

}
