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
    
    init(netowrkModel: NetworkModel) {
        self.netowrkModel = netowrkModel
    }
    
    func fetchFromCoreData(completion: (([InstabugNetworkClient.NetworkModel]) -> Void)) {
        completion([netowrkModel])
    }
    
    func saveInCoreData(_ item: InstabugNetworkClient.NetworkModel, completion: ((InstabugNetworkClient.NetworkEntity) -> Void)?) {
        netowrkModel = item
    }
    
    
}
