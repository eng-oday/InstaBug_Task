//
//  NetworkClientProtocol.swift
//  InstabugNetworkClient
//
//  Created by user on 11/08/2023.
//

import Foundation


protocol NetworkClientProtocol{
     func get(_ url: URL, completionHandler: @escaping (Data?) -> Void)
     func post(_ url: URL, payload: Data, completionHandler: @escaping (Data?) -> Void)
     func put(_ url: URL, payload: Data, completionHandler: @escaping (Data?) -> Void)
     func delete(_ url: URL, completionHandler: @escaping (Data?) -> Void)
}
