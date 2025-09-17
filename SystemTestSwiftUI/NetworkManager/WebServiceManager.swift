//
//  WebServiceManager.swift
//  MVVMDemo
//
//  Created by Mahaboob on 25/08/25.
//  Converted to URLSession (async/await) version
//

import Foundation

/// Placeholder struct used when API response body is empty (e.g., 204 No Content)
struct None: Codable {}

/// Common HTTP response status codes used for better readability
enum ResponseStatus: Int {
    case successCreation = 201
    case success = 200
    case successDeletion = 204
    case unauthorized = 401
    case notFound = 404
}

/// Singleton class responsible for handling all network requests
/// using URLSession with async/await for cleaner syntax.
final class WebServiceManager {
    
    /// Shared singleton instance
    static let shared = WebServiceManager()
    
    /// Private initializer to enforce singleton usage
    private init() {}
    
    // MARK: - Helper: Make Request
    private func request<T: Codable>(
        endpoint: APIEndpoint,
        method: String,
        headers: [String: String]? = nil,
        body: Data? = nil,
        responseType: T.Type
    ) async throws -> T {
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Apply custom headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            // Special case: No content
            if T.self == None.self, data.isEmpty {
                return None() as! T
            }
            return try JSONDecoder().decode(T.self, from: data)
        case 401:
            throw NSError(domain: "Unauthorized", code: ResponseStatus.unauthorized.rawValue)
        case 404:
            throw NSError(domain: "Not Found", code: ResponseStatus.notFound.rawValue)
        default:
            throw NSError(domain: "HTTP Error", code: httpResponse.statusCode)
        }
    }
    
    // MARK: - GET Request
    func getRequest<T: Codable>(
        endpoint: APIEndpoint,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await request(endpoint: endpoint, method: "GET", headers: headers, responseType: T.self)
    }
    
    // MARK: - POST Request
    func postRequest<T: Codable, U: Encodable>(
        endpoint: APIEndpoint,
        body: U,
        headers: [String: String]? = nil
    ) async throws -> T {
        let bodyData = try JSONEncoder().encode(body)
        return try await request(endpoint: endpoint, method: "POST", headers: headers, body: bodyData, responseType: T.self)
    }
    
    // MARK: - PUT Request
    func putRequest<T: Codable, U: Encodable>(
        endpoint: APIEndpoint,
        body: U,
        headers: [String: String]? = nil
    ) async throws -> T {
        let bodyData = try JSONEncoder().encode(body)
        return try await request(endpoint: endpoint, method: "PUT", headers: headers, body: bodyData, responseType: T.self)
    }
    
    // MARK: - DELETE Request
    func deleteRequest<T: Codable>(
        endpoint: APIEndpoint,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await request(endpoint: endpoint, method: "DELETE", headers: headers, responseType: T.self)
    }
}
