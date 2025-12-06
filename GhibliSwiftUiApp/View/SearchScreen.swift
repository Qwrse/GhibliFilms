//
//  SearchScreen.swift
//  GhibliSwiftUiApp
//
//  Created by dimss on 06/12/2025.
//

import SwiftUI

struct SearchScreen: View {
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            Text("Search Screen")
                .searchable(text: $text)
        }
    }
}

#Preview {
    SearchScreen()
}
