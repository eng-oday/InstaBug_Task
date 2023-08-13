//
//  CoreDataManagerMock.swift
//  InstabugNetworkClientTests
//
//  Created by user on 12/08/2023.
//

import Foundation
import CoreData
@testable import InstabugNetworkClient

class CoreDataManagerMock:CoreDataManager{
    
    override init() {
            super.init()
            
            persistentContainer = NSPersistentContainer(name: Constants.modelName)
            let description = persistentContainer.persistentStoreDescriptions.first
            description?.type = NSInMemoryStoreType
    
            persistentContainer.loadPersistentStores { description, error in
                guard error == nil else {
                    fatalError("was unable to load store \(error!)")
                }
            }
    
//            let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//            mainContext.automaticallyMergesChangesFromParent = true
//            mainContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
    
            customViewContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            customViewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            customViewContext.parent = persistentContainer.viewContext
        }
    
    
}

