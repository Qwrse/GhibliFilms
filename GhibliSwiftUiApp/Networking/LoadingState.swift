//
//  LoadingState.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case error(String)
    
    var data: T? {
        if case .loaded(let value) = self {
            return value
        }
        return nil
    }
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var error: String? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
}
