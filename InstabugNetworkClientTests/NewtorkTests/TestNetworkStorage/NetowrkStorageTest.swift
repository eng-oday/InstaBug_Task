//
//  NetowrkStorageTest.swift
//  InstabugNetworkClientTests
//
//  Created by user on 12/08/2023.
//

import XCTest
import CoreData

@testable import InstabugNetworkClient
final class NetowrkStorageTest: XCTestCase {
    
    var sut:NetworkStorageProtocol!
    var coreDataManager:CoreDataManagerMock!
    var limits:LimitsNetworkProtocol!
    

    override func setUp() {
        coreDataManager = CoreDataManagerMock()
        limits          = LimitsNetworkMock()
        sut = NetworkStorage(coreDataManager: coreDataManager, limits: limits )
    }
    
    override func tearDown() {
        coreDataManager = nil
        limits          = nil
        sut             = nil
    }

    
    func testNetowrkStorage_WhenSaveInCoreDataOneRecord_ExpextItSavedSuccessfully(){
        
        //ARRANGE
        
        // ACT
        sut.saveInCoreData(NetworkModelMock.networkModel) { itemSaved in
            //ASERT
            XCTAssertEqual(itemSaved.errorCode, NetworkModelMock.networkModel.errorCode)
            XCTAssertEqual(itemSaved.requestPayload, NetworkModelMock.networkModel.payloadRequest)
        }
    }
    
    
    
}
