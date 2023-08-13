//
//  InstabugNetworkClientTests.swift
//  InstabugNetworkClientTests
//
//  Created by Yousef Hamza on 1/13/21.
//

import XCTest
@testable import InstabugNetworkClient

class InstabugNetworkClientTests: XCTestCase {

    var sut:NetworkClient!
    var urlSession:URLSession!
    var limits:LimitsNetworkProtocol!
    var networkStorage:NetworkStorageProtocol!
    var networkModel:NetworkModel!
    var jsonString:String!
    
    override func setUp() {
        let config                          = URLSessionConfiguration.ephemeral
        config.protocolClasses              = [UrlProtocolMock.self]
        urlSession                          = URLSession(configuration: config)
        jsonString                          = "{\"status\":\"ok\"}"
        UrlProtocolMock.stubResponse        =  jsonString.data(using: .utf8)
        limits                              = LimitsNetworkMock()
        networkModel                        =  NetworkModelMock.networkModel
        networkStorage                      = NetworkStorageMock(netowrkModel: networkModel )
        sut                                 = NetworkClient(urlSession: urlSession,limits: limits,networkStorage: networkStorage)
    }
    
    override func tearDown() {
        sut                             = nil
        urlSession                      = nil
        limits                          = nil
        UrlProtocolMock.stubResponse    = nil
        UrlProtocolMock.error           = nil
        networkModel                    = nil
        networkStorage                  = nil
    }
    
    func testNetworkClient_WhenSendGetRequest_ExpectToGetSuccessResponse(){
        // ARRANGE
        let expectasion                     = expectation(description: "am expect to get success response but it not complete.")
        // ACT
        sut.get(Constants.url) { Data in
        //ASSERT
        expectasion.fulfill()
        XCTAssertNotNil(Data , "i am expect to get data when i send get request but i get nil ")
        }
        self.wait(for: [expectasion], timeout: 5)
    }
    
    
    func testNetworkClient_WhenSendGetRequestWithError_ExpectToGetEmptyData(){
        //ARRANGE
        let expectasion                     = expectation(description: "am expect to get success response but it not complete.")
        let errorDescription                = "Localized Description Of An Error"
        UrlProtocolMock.error               = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        
        // ACT
        sut.get(Constants.url) { Data in
        //ASSERT
        expectasion.fulfill()
        XCTAssertNil(Data , "i am expect to get nil when i send get request but i get Data ")
        }
        self.wait(for: [expectasion], timeout: 5)
    }
    
    func testNetworkClient_WhenSendPostRequest_ExpectToGetSuccessResponse(){
        //ARRANGE
        let expectasion                     = expectation(description: "am expect to get success response but it not complete.")
        
        //ACT
        sut.post(Constants.url, payload: UrlProtocolMock.stubResponse!) { Response in
            expectasion.fulfill()
            //ASSERT
            XCTAssertNotNil(Response , "i am expect to get success response when i send Post request but i get nil ")
        }
        self.wait(for: [expectasion], timeout: 5)
    }
    
    func testNetworkClient_WhenSendPostRequestWithError_ExpectToGetEmptyData(){
        //ARRANGE
        let expectasion                     = expectation(description: "am expect to get success response but it not complete.")
        let errorDescription                = "Localized Description Of An Error"
        UrlProtocolMock.error               = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])

        // ACT
        sut.post(Constants.url, payload: UrlProtocolMock.stubResponse!) { Data in
            expectasion.fulfill()
            //ASSERT
            XCTAssertNil(Data , "i am expect to get Failed response when i send Post request but i get Data ")
        }
        self.wait(for: [expectasion], timeout: 5)
    }
    
}
