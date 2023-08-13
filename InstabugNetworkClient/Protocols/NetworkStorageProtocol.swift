//
//  NetworkStorageProtocol.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation
import CoreData

protocol NetworkStorageProtocol {
    func fetchFromCoreData(completion: (([NetworkModel]) -> Void))
    func saveInCoreData(_ item: NetworkModel, completion: ((NetworkEntity) -> Void)?)
}
