//
//  LimitsNetwork.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation

struct LimitsNetwork:LimitsNetworkProtocol {
    var records: Int = Constants.records
    var maxPayloadSize: Int = Constants.maxPayload
}
