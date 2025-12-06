//
//  APIError.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 04/12/2025.
//


import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response from server"
        case .decoding(let error): return "Failed to decore response: \(error.localizedDescription)"
        case .networkError(let error): return "Network Error: \(error.localizedDescription)"
        }
    }
}
