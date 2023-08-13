//
//  NetworkStorage.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation
import CoreData

class NetworkStorage:NetworkStorageProtocol {
    
    var coreDataManager:CoreDataManagerProtocol
    var limits:LimitsNetworkProtocol
    
    init(coreDataManager:CoreDataManagerProtocol, limits:LimitsNetworkProtocol = LimitsNetwork()) {
        self.coreDataManager    = coreDataManager
        self.limits             = limits
    }
    
    func saveInCoreData(_ item: NetworkModel, completion: ((NetworkEntity) -> Void)?) {
        if checkIfRecordAboveLimits(){
            deleteFirstRecord()
        }else {
            coreDataManager.PersistantContainer.newBackgroundContext().perform { [weak self ] in
                guard let self else {return}
                let NetworkEntityRecord = NetworkEntity(context: self.coreDataManager.PersistantContainer.newBackgroundContext())
                // Request
                NetworkEntityRecord.httpMethod        = item.httpMethod
                NetworkEntityRecord.url               = item.URL
                NetworkEntityRecord.requestPayload    = item.payloadRequest
                // Response
                NetworkEntityRecord.statusCode        = item.statusCode
                NetworkEntityRecord.responsePayload   = item.payloadResponse
                NetworkEntityRecord.errorDomain       = item.errorDomain
                self.coreDataManager.performSaveOpertaionOnBackground()
                completion?(NetworkEntityRecord)
            }
        }
    }
    
    func fetchFromCoreData(completion: @escaping(([NetworkModel]) -> Void)) {
        coreDataManager.fetch { [weak self] reult in
            guard let self else {return}
            if case .success(let records) = reult {
                let netowrkModel = records.map(self.convertNetworkEntityRecordToNetworkModel(_:))
                completion(netowrkModel)
            }
        }
    }
    
    func checkIfRecordAboveLimits() -> Bool{
        var isAbove:Bool = false
        coreDataManager.getRecordCount { [weak self] recordCount in
            guard let self else {return}
            isAbove = self.limits.records <= recordCount
        }
        return isAbove
    }
    
    private func deleteFirstRecord() {
        coreDataManager.fetch { [weak self] result in
            guard let self else {return}
            if case .success(let success) = result {
                if let firstRecordMustDeleted = success.first {
                    self.coreDataManager.delete(item: firstRecordMustDeleted)
                }
            }
        }
     }

    
    private func convertNetworkEntityRecordToNetworkModel(_ item: NetworkEntity) -> NetworkModel {
        return NetworkModel(statusCode: item.statusCode ?? "", payloadResponse: item.responsePayload ?? "", errorDomain: item.errorDomain ?? "" , errorCode: item.errorCode ?? "", httpMethod: item.httpMethod ?? "", URL: item.url ?? "", payloadRequest: item.requestPayload ?? "")
    }

    

    
    
}
