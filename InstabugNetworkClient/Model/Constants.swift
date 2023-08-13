//
//  Constants.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation


enum Constants {
    static let records          = 1000
    static let maxPayload       = 1024 * 1024
    static let payLoadToLarge   = "Payload too large"
    static let modelName        = "NetworkModel"
    static let url:URL          = URL(string: "https://httpbin.org/get")!

}
