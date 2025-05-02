//
//  FoodPage.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//
import SwiftUI

struct ReviewPage: View {
    @Environment(\.dismiss) var dismiss
    
    var food: Food
    var user: User
    
    @StateObject var reviewViewModel = ReviewViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ZStack (alignment: .topLeading) {
                    AsyncImage(url: URL(string: food.imageUrl)) {
                        phase in
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
                        case .failure(_):
                            ProgressView()
                                .frame(height: 275)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Color.black.opacity(0.5)
                    
                    VStack(alignment: .leading) {
                            Spacer()
                            Text(food.name)
                                .font(.system(size: 30, weight: .heavy))
                                .foregroundColor(.white)
                                .padding(25)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    
                    Button{
                            dismiss()
                    }label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(12)
                        }
                        .padding(.leading, 16)
                        .padding(.top, 50)
                }
                .padding(.bottom)
                
                VStack (spacing: 40) {
                    MakeReviewCell(
                        rating: $reviewViewModel.rating,
                        message: $reviewViewModel.reviewText,
                        onPost: {
                            reviewViewModel.submitReview(userId: user.id, foodId: food.id)
                        }
                    )
                    
                    VStack (spacing: 20){
                        ForEach(reviewViewModel.reviews, id: \.id) { review in
                            ReviewCell(review: review)
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
            .onAppear {
                reviewViewModel.fetchReviews(foodId: food.id)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
    }
}

