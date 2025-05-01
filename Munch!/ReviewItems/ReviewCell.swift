//
//  ReviewCell.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//
import SwiftUI

struct ReviewCell: View {
    let review: Review

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                // Top row: profile + username + stars
                HStack(alignment: .center) {
                    Image(systemName: "person.circle.fill") // Or use review.profileImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .foregroundColor(.gray)

                    Text(review.username)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)

                    Spacer()

                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(index <= Int(review.rating.rounded()) ? .yellow : .gray.opacity(0.3))
                        }
                    }
                }

                // Review message (uppercase, gray)
                Text(review.review)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 0)
            .padding(.horizontal)
        }
}

#Preview {
    ReviewCell(review: Review.dummyData[0])
}
