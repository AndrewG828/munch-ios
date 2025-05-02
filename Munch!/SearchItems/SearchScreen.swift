//
//  SearchScreen.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//

import SwiftUI

struct SearchScreen: View {
    
    var user: User
    
    @State private var searchQuery = ""
    @State private var categories: [String] = []
    @State private var selectedCategory: String? = nil
    
    @State private var showCategoryFoodScreen = false
    
    var filters: [(String, String)] = [("Location", "Nearby"), ("Trending", "Trending"), ("Friends", "Friends")]
    
    var displayedCategories: [String] {
        if searchQuery.isEmpty {
            return categories
        } else {
            let lowerQuery = searchQuery.lowercased()
            let matched = categories.filter { $0.lowercased().contains(lowerQuery) }
            let unmatched = categories.filter { !$0.lowercased().contains(lowerQuery) }
            return matched + unmatched
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 20) {
                
                // Title
                Text("Munch!")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.top, 8)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                        .frame(width: 15, height: 15)
                    
                    TextField("Search categories", text: $searchQuery)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.leading)
                .padding(.vertical, 11)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(UIColor.munch.lightGray).opacity(0.8))
                )
                
                // Filter Pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(filters.indices, id: \.self) { index in
                            let filteri = filters[index]
                            Button {
                                // Handle filter tap
                            } label: {
                                HStack {
                                    Image(filteri.0)
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                    
                                    Text(filteri.1)
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal)
                                .font(.system(size: 11, weight: .semibold))
                                .background(Capsule().fill(Color(UIColor.munch.lightGray).opacity(0.8)))
                                .foregroundColor(.black)
                            }
                        }
                    }
                }
                
                // Category List
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(displayedCategories, id: \.self) { cat in
                            Button {
                                if selectedCategory == cat {
                                    selectedCategory = nil
                                } else {
                                    selectedCategory = cat
                                    showCategoryFoodScreen = true
                                }
                            } label: {
                                Text(cat)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(selectedCategory == cat
                                                  ?
                                                  Color(UIColor.munch.beige).opacity(0.6)
                                                  :
                                                    Color(UIColor.munch.gray).opacity(0.05))
                                    )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .padding(.horizontal, 35)
            .padding(.top)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $showCategoryFoodScreen) {
                if let category = selectedCategory {
                    CategoryFoodScreen(category: category, user: user)
                }
            }
            .onAppear {
                NetworkManager.shared.fetchCategories { response in
                    if let categoryList = response?.categories {
                        self.categories = categoryList
                    }
                }
            }
        }
    }
}

