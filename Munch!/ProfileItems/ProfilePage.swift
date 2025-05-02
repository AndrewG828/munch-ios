//
//  ProfilePage.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//
import SwiftUI
import PhotosUI

struct ProfilePage: View {
    var user: User
    
    @State private var profileImage: Image? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 25){
                VStack{
                    HStack {
                        Spacer()
                        
                        if let data = user.profileImage {
                            if let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            }
                        } else {
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                ZStack(alignment: .bottomTrailing) {
                                    if let profileImage = profileImage {
                                        profileImage
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 120, height: 120)
                                            .clipShape(Circle())
                                    } else {
                                        Circle()
                                            .fill(Color.gray.opacity(0.5))
                                            .frame(width: 120, height: 120)
                                            .overlay(
                                                Image("User")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 60, height: 60)
                                            )
                                    }
                                    
                                    // Plus icon
                                    ZStack {
                                        Circle()
                                            .fill(Color.black)
                                            .frame(width: 35, height: 35)
                                        Image("Plus")
                                    }
                                    .offset(x: 2, y: -8)
                                }
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        self.imageData = data
                                        self.profileImage = Image(uiImage: uiImage)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    
                    Text(user.username)
                        .font(.system(size: 20, weight: .heavy))
                        .frame(maxWidth: .infinity)
                }
                
                VStack (alignment: .leading) {
                    Text("Activity Center")
                        .font(.system(size: 16, weight: .heavy))
                    
                    HStack {
                        Text("💰 Jason Guo")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        
                        Text("$32.95")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 6)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2)))
                    
                    HStack {
                        Text("🍟 Cajun Fries")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        
                        Text("Rate Now!")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 6)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2)))
                    
                    HStack {
                        Text("💰 Jimmy Chen")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        
                        Text("$25.50")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 6)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2)))
                }
                VStack (alignment: .leading){
                    Text("Your Ratings")
                        .font(.system(size: 16, weight: .heavy))
                    
                    ForEach(Food.dummyData, id: \.id){ food in
                        FoodCell(food: food)
                    }
                }
                
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    ProfilePage(user: User.dummyData[0])
}
