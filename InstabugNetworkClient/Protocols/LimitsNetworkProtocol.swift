//
//  LimitsNetworkProtocol.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation


protocol LimitsNetworkProtocol {
    var records: Int { get }
    var maxPayloadSize: Int { get }
}
