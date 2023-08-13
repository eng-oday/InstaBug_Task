//
//  MockUrlProtocol.swift
//  InstabugNetworkClientTests
//
//  Created by user on 11/08/2023.
//

import Foundation

class UrlProtocolMock:URLProtocol {
    
    static var stubResponse:Data? // Stub Data For Success Response
    static var error:Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        if let error = UrlProtocolMock.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }else {
            self.client?.urlProtocol(self, didLoad: UrlProtocolMock.stubResponse ?? Data()) // simulate as Response is backed successed
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
    
}
