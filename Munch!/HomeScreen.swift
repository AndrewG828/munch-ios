//
//  HomeScreen.swift
//  Munch!
//
//  Created by Andrew Gao on 4/29/25.
//

import SwiftUI
struct HomeScreen: View {
    @State private var search: String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            TextField("Search stores and products", text: $search)
                .padding()
                .background(Color(.systemGray6))
            
            Text("Food Near You")
            
            HStack {
                
            }
            
            Spacer()
        }
    }
}

#Preview {
    HomeScreen()
}
