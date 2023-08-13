//
//  CoreDataManagerProtocol.swift
//  InstabugNetworkClient
//
//  Created by user on 12/08/2023.
//

import Foundation
import CoreData


protocol CoreDataManagerProtocol {
    var PersistantContainer: NSPersistentContainer {get}
    var managedObjectModel: NSManagedObjectModel {get}
    func getRecordCount(completion: @escaping (Int) -> Void)
    func delete(item: NetworkEntity)
    func fetch(completion: (@escaping(Result<[NetworkEntity], Error>) -> Void))
    func performSaveOpertaionOnBackground()
}
