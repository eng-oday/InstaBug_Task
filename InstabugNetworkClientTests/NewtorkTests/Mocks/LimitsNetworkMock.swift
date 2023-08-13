//
//  LimitsNetworkMock.swift
//  InstabugNetworkClientTests
//
//  Created by user on 11/08/2023.
//

import Foundation
@testable import InstabugNetworkClient

class LimitsNetworkMock:LimitsNetworkProtocol {
    
    var smallPayloadTest = false
    var records: Int {
        return 1
    }
    var maxPayloadSize: Int {
        return smallPayloadTest ? 10 : 1000
    }
}
