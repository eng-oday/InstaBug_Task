//
//  NetworkClient.swift
//  InstabugNetworkClient
//
//  Created by Yousef Hamza on 1/13/21.
//

import Foundation

public class NetworkClient {

    public static var shared = NetworkClient()
    private let networkStorage: NetworkStorageProtocol
    private var urlSession:URLSession
    private var limits:LimitsNetworkProtocol
    
    
    init(urlSession: URLSession = .shared , limits:LimitsNetworkProtocol = LimitsNetwork(),networkStorage:NetworkStorageProtocol = NetworkStorage()) {
        self.urlSession         = urlSession
        self.limits             = limits
        self.networkStorage     = networkStorage
    }

    func executeRequest(_ url: URL, method: String, payload: Data?, completionHandler: @escaping (Data?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = payload
        
       let dataTask =  urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
           
           if let _ = error {
               return completionHandler(nil)
           }
           if let data = data {
               DispatchQueue.main.async {
                   self.CreateNetworkModel(request: urlRequest , response: response, data: data, error: error)
                   completionHandler(data)
               }
           }
        }
        dataTask.resume()
    }

    private func CreateNetworkModel(request: URLRequest,response: URLResponse?,data: Data?,error: Error?) {
        let networModelCreator      = NetworkModelCreator(request: request, limits: limits, response:response ,Data:data , error:error)
        let networkModel            = networModelCreator.createNetworkModelfromData()
        SaveNetworkModel(networkModel)
    }
    
    private func SaveNetworkModel(_ networkModel:NetworkModel) {
        networkStorage.saveInCoreData(networkModel, completion: nil)
    }

    // MARK: Network recording
    public func allNetworkRequests() -> Any {
        fatalError("Not implemented")
    }
}


extension NetworkClient:NetworkClientProtocol {
    // MARK: Network requests
     func get(_ url: URL, completionHandler: @escaping (Data?) -> Void) {
        executeRequest(url, method: "GET", payload: nil, completionHandler: completionHandler)
    }

    func post(_ url: URL, payload: Data, completionHandler: @escaping (Data?) -> Void) {
        executeRequest(url, method: "POSt", payload: payload, completionHandler: completionHandler)
    }
    
    func put(_ url: URL, payload: Data, completionHandler: @escaping (Data?) -> Void) {
        executeRequest(url, method: "PUT", payload: payload, completionHandler: completionHandler)
    }

     func delete(_ url: URL, completionHandler: @escaping (Data?) -> Void) {
        executeRequest(url, method: "DELETE", payload: nil, completionHandler: completionHandler)
    }
}
