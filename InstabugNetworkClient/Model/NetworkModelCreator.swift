//
//  NetworkModelCreator.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation


class NetworkModelCreator{
    private var request:URLRequest
    private var response:URLResponse?
    private var Data:Data?
    private var error:Error?
    private let limits: LimitsNetworkProtocol
    
    init(request: URLRequest, limits: LimitsNetworkProtocol , response:URLResponse? ,Data:Data? , error:Error?) {
        self.request = request
        self.Data = Data
        self.limits = limits
        self.response = response
        self.error = error
    }
    
    //MARK: - Request Model
    
    func setRequestMethod() -> String {
        request.httpMethod ?? ""
    }
    
    func setUrlMethod() -> String {
        request.url?.absoluteString ?? ""
    }
    
    func setRequestPayload() -> String {
        convertPayloadToString(data: request.httpBody)
    }

    
    // MARK: - Response Model
    func setStatusCode() -> String {
        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            return "\(statusCode)"
        }else {
            return ""
        }
    }
    
    func setErrorCode() -> String {
        if let errorCode =  (error as NSError?)?.code {
            return "\(errorCode)"
        }else {
            return ""
        }
    }
    
    func setErrorDomain() -> String{
        return error?.localizedDescription ?? ""
    }
    
    func setResponsePayload() -> String
    {
        return convertPayloadToString(data: Data)
    }
    
    
    //MARK: - Convert Payload to string
    private func convertPayloadToString(data: Data?) -> String {
        guard let data = data else {
            return ""
        }
        
        guard data.count <= limits.maxPayloadSize else {
            return Constants.payLoadToLarge
        }
        
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    
    //MARK: - create NetowrkModel
    func createNetworkModelfromData() -> NetworkModel {
        NetworkModel(statusCode: setStatusCode(), payloadResponse: setResponsePayload(), errorDomain: setErrorDomain(), errorCode: setErrorCode(),httpMethod: setRequestMethod(), URL: setUrlMethod(), payloadRequest: setRequestPayload())
    }
    
}
