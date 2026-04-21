//
//  GhibliSwiftUiApp.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 03/12/2025.
//

import SwiftUI

/// The app entry point.
@main
struct GhibliSwiftUiApp: App {
    /// Controls whether the app forces a light color scheme.
    @AppStorage("useLightMode") var prefersLightMode: Bool = false
    
    /// Creates the root scene for the app.
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(prefersLightMode ? .light : .dark)
        }
    }
}
