//
//  SettingsScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

struct SettingsScreen: View {
    @State private var showingDeleteConfirmation: Bool = false
    @AppStorage("useLightMode") var useLightMode: Bool = false
    
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Toggle(isOn: $useLightMode) {
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
                            favoritesViewModel.removeAll()
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
