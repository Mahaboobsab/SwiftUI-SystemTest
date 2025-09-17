//
//  MockWebService.swift
//  SystemTestSwiftUI
//
//  Created by Meheboob on 17/09/25.
//

import Testing
@testable import SystemTestSwiftUI

final class MockWebService: WebServiceProtocol {
    var mockItems: [Item] = []
    
    func getRequest<T>(endpoint: APIEndpoint, headers: [String : String]?) async throws -> T where T : Decodable, T : Encodable {
        return mockItems as! T
    }
    
    func postRequest<T, U>(endpoint: APIEndpoint, body: U, headers: [String : String]?) async throws -> T where T : Decodable, T : Encodable, U : Encodable {
        return body as! T
    }
    
    func putRequest<T, U>(endpoint: APIEndpoint, body: U, headers: [String : String]?) async throws -> T where T : Decodable, T : Encodable, U : Encodable {
        return body as! T
    }
    
    func deleteRequest<T>(endpoint: APIEndpoint, headers: [String : String]?) async throws -> T where T : Decodable, T : Encodable {
        return None() as! T
    }
}

