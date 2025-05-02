//
//  CategoryFoodScreen.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//
import SwiftUI

struct CategoryFoodScreen: View {
    var category: String
    var user: User

    @StateObject var foodViewModel = FoodViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // Header image and category title
                ZStack(alignment: .topLeading) {
                    if let firstFood = foodViewModel.categoryFoods.first {
                        AsyncImage(url: URL(string: firstFood.imageUrl)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 275)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 275)
                                    .clipped()
                            case .failure:
                                Color.gray.frame(height: 275)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        Color.black.opacity(0.5)
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(firstFood.category)
                                .font(.system(size: 30, weight: .heavy))
                                .foregroundColor(.white)
                                .padding(25)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    } else {
                        ProgressView()
                            .frame(height: 275)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }

                    // Back button
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(12)
                    }
                    .padding(.leading, 16)
                    .padding(.top, 50)
                }
                .padding(.bottom)

                // Food List
                if foodViewModel.categoryFoods.isEmpty {
                    VStack {
                        ProgressView("Loading foods...")
                            .padding()
                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    VStack(spacing: 20) {
                        ForEach(
                            foodViewModel.categoryFoods.sorted(by: { $0.rating > $1.rating }),
                            id: \.id
                        ) { food in
                            NavigationLink(destination: ReviewPage(food: food, user: user)) {
                                FoodCell(food: food)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
        }
        .onAppear {
            foodViewModel.getAllFoodsByCategory(selectedCategory: category)
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
    }
}
