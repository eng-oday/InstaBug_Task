//
//  NetworkModelMock.swift
//  InstabugNetworkClientTests
//
//  Created by user on 12/08/2023.
//

import Foundation
@testable import InstabugNetworkClient



class NetworkModelMock {
    static let networkModel = NetworkModel(statusCode: "20", payloadResponse: "response payload", errorDomain: "error domain", errorCode: "error code ", httpMethod: "GET", URL: "https://httpbin.org/get", payloadRequest: "PayLoadRequest")
}
