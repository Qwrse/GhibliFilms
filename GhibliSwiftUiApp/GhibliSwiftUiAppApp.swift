//
//  GhibliSwiftUiAppApp.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 03/12/2025.
//

import SwiftUI

@main
struct GhibliSwiftUiAppApp: App {
    @AppStorage("useLightMode") var useLightMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(useLightMode ? .light : .dark)
        }
    }
}
