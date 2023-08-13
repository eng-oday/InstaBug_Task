//
//  MockNetworkStorage.swift
//  InstabugNetworkClientTests
//
//  Created by user on 12/08/2023.
//

import Foundation
@testable import InstabugNetworkClient

class NetworkStorageMock:NetworkStorageProtocol{
    
    var netowrkModel:NetworkModel
//
//    var coreDataManager:CoreDataManager
//    var limits:LimitsNetworkProtocol
    
    init(netowrkModel: NetworkModel) {
//        self.coreDataManager    = coreDataManager
//        self.limits             = limits
        self.netowrkModel = netowrkModel

    }
    func fetchFromCoreData(completion: (([InstabugNetworkClient.NetworkModel]) -> Void)) {
//        coreDataManager.fetch { result in
//            print(result)
//        }
    }
    
    func saveInCoreData(_ item: InstabugNetworkClient.NetworkModel, completion: ((InstabugNetworkClient.NetworkEntity) -> Void)?) {
//        coreDataManager.performSaveOpertaionOnBackground()
    }
    
    
}
