//
//  NetworkResponseModel.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation


struct NetworkModel:Codable {
    //Response
    var statusCode:String
    var payloadResponse:String
    var errorDomain:String
    var errorCode:String
    //Request
    var httpMethod:String
    var URL:String
    var payloadRequest:String
}

