//
//  StarRating.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//
import SwiftUI

struct StarRatingView: View {
    let rating: Float
    let maxStars = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxStars, id: \.self) { index in
                let starValue = Float(index) + 1
                if rating >= starValue {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                } else if rating >= starValue - 0.5 {
                    Image(systemName: "star.lefthalf.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.gray.opacity(0.6))
                }
            }
        }
    }
}
