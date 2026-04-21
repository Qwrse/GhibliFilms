//
//  SettingsScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

/// Displays app settings.
struct SettingsScreen: View {
    /// Controls the delete confirmation dialog.
    @State private var showingDeleteConfirmation: Bool = false
    /// Controls whether the app uses a light color scheme.
    @AppStorage("useLightMode") var prefersLightMode: Bool = false
    
    /// The favorites view model used to clear saved favorites.
    let favoritesViewModel: FavoritesViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Toggle(isOn: $prefersLightMode) {
                        Text("Use light mode")
                    }
                }
                Section("Danger") {
                    Button("Delete favorites", role: .destructive) {
                        showingDeleteConfirmation = true
                    }
                    .confirmationDialog("Delete favorites films",
                                        isPresented: $showingDeleteConfirmation,
                                        titleVisibility: .visible) {
                        Button("Delete", role: .destructive) {
                            favoritesViewModel.removeAllFavorites()
                        }
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Are you sure you want to delete all favorite films? This action cannot be undone.")
                    }
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
}


#Preview {
    SettingsScreen(favoritesViewModel: FavoritesViewModel())
}
