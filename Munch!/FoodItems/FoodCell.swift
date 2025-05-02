//
//  FoodCell.swift
//  Munch!
//
//  Created by Andrew Gao on 4/30/25.
//

import SwiftUI

struct FoodCell: View {
    var food: Food
    
    var body: some View {
        VStack (spacing: 16) {
            AsyncImage(url: URL(string: food.imageUrl)) {
                phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 350, height: 160)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 160)
                        
                        .clipped()
                case .failure(_):
                    ProgressView()
                        .frame(width: 350, height: 160)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack (spacing: 8) {
                HStack {
                    Text(food.name)
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    StarRatingView(rating: food.rating)
                }
                .padding(.horizontal, 8)
                
                HStack {
                    Text("$\(String(format: "%.2f", food.price)) - Restaurant Info")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(.leading, 8)
            }
        }
        .padding(.bottom)
        .frame(width: 350)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 4)
        )
    }
}

#Preview{
    FoodCell(food: Food(id: 1, name: "Yummy", price: 10.01, category: "Yum", imageUrl: "https://www.shutterstock.com/image-vector/yummy-word-pop-art-retro-260nw-1111964420.jpg", rating: 4.5, restaurant: RestaurantResponse(id: 1, name: "yay", address: "yum")))
}


