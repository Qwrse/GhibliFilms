//
//  APIError.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//


import Foundation

/// Describes errors that can occur while communicating with the API.
enum APIError: LocalizedError {
    /// Indicates that a URL string could not be converted into a valid URL.
    case invalidURL
    /// Indicates that the server returned an unexpected response.
    case invalidResponse
    /// Indicates that response decoding failed.
    case decoding(Error)
    /// Indicates that the request failed at the network layer.
    case networkError(Error)
    
    /// Returns a localized description for the error.
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response from server"
        case .decoding(let error): return "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error): return "Network Error: \(error.localizedDescription)"
        }
    }
}
