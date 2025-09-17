//
//  WebServiceProtocol.swift
//  SystemTestSwiftUI
//
//  Created by Meheboob on 17/09/25.
//

protocol WebServiceProtocol {
    func getRequest<T: Codable>(endpoint: APIEndpoint,
                                headers: [String: String]?) async throws -> T
    
    func postRequest<T: Codable, U: Encodable>(endpoint: APIEndpoint,
                                               body: U,
                                               headers: [String: String]?) async throws -> T
    
    func putRequest<T: Codable, U: Encodable>(endpoint: APIEndpoint,
                                              body: U,
                                              headers: [String: String]?) async throws -> T
    
    func deleteRequest<T: Codable>(endpoint: APIEndpoint,
                                   headers: [String: String]?) async throws -> T
}

extension WebServiceManager: WebServiceProtocol {}
