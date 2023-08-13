//
//  CoreDataManagerMock.swift
//  InstabugNetworkClientTests
//
//  Created by user on 13/08/2023.
//

import Foundation
import CoreData

@testable import InstabugNetworkClient
class CoreDataManagerMock: CoreDataManagerProtocol {

    
    
    lazy var PersistantContainer: NSPersistentContainer = {
            
        let container = NSPersistentContainer(name: Constants.modelName, managedObjectModel: self.managedObjectModel)
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            description.shouldAddStoreAsynchronously = false // Make it simpler in test env
            
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { (description, error) in
                // Check if the data store is in memory
                precondition( description.type == NSInMemoryStoreType )
                                            
                // Check if creating container wrong
                if let error = error {
                    fatalError("Create an in-mem coordinator failed \(error)")
                }
            }
            return container
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
            let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
            return managedObjectModel
        }()
    
    func delete(item: InstabugNetworkClient.NetworkEntity) {
        
    }
    
    func fetch(completion: @escaping ((Result<[InstabugNetworkClient.NetworkEntity], Error>) -> Void)) {
        
    }
    
    func performSaveOpertaionOnBackground() {
        
    }
    
    func getRecordCount(completion: @escaping (Int) -> Void) {
        
    }
    
    
}
