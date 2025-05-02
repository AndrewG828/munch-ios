//
//  NearYouCell.swift
//  Munch!
//
//  Created by Andrew Gao on 4/30/25.
//
import SwiftUI

struct NearYouCell: View {
    @State var restuarant: Restaurant
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: restuarant.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                case .failure(_):
                    ProgressView()
                        .frame(width: 100, height: 100)
                @unknown default:
                    EmptyView()
                }
            }
            
            Color.black.opacity(0.3)
            
            Text(restuarant.name)
                .font(.system(size: 12, weight: .heavy))
                .foregroundColor(.white)
                .padding(8)
        }
        .frame(width: 100, height: 100)
        .cornerRadius(12)
        .clipped()
    }
}

