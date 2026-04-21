//
//  LoadingState.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation

/// Represents the loading lifecycle for asynchronously fetched content.
enum LoadingState<T> {
    /// The request has not started yet.
    case idle
    /// The request is currently in progress.
    case loading
    /// The request succeeded and produced a value.
    case loaded(T)
    /// The request failed with an error message.
    case error(String)
    
    /// Returns the loaded value when the state is `.loaded`.
    var loadedValue: T? {
        if case .loaded(let value) = self {
            return value
        }
        return nil
    }
    
    /// Indicates whether the state is currently loading.
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    /// Returns the current error message when the state is `.error`.
    var errorMessage: String? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
}
