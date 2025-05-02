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
    
    @Environment(\.dismiss) var dismiss
    
    @State private var profileImage: Image? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    @State private var navigateToReview = false
    @State private var selectedFood: Food? = nil
    
    @StateObject var foodViewModel = FoodViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                }
                Spacer()
            }
            .padding(.leading)

            ScrollView(.vertical, showsIndicators: false) {
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
                        
                        activityRow(name: "Jason Guo", amount: 32.95, venmo: "jasonguo1")
                        activityRow(name: "Fanhao Yu", amount: 25.50, venmo: "Fanhao-Yu")
                    
                        if let matchedFood = foodViewModel.foods.first(where: { $0.name == "House Pho 1" && $0.id == 2 }) {
                            Button {
                                selectedFood = matchedFood
                                navigateToReview = true
                            } label: {
                                HStack {
                                    Text("🍜 House Pho 1")
                                        .font(.system(size: 16, weight: .semibold))

                                    Spacer()

                                    Text("Rate Now!")
                                        .font(.system(size: 16, weight: .semibold))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(.black)
                        }
                    }
                    
                    VStack (alignment: .leading){
                        Text("Your Ratings")
                            .font(.system(size: 16, weight: .heavy))
                        
                        ForEach(foodViewModel.foods, id: \.id){ food in
                            FoodCell(food: food)
                        }
                    }
                    
                }
                .padding(.horizontal, 35)
                .padding(.vertical, 20)
                .onAppear {
                    foodViewModel.getAllFoods()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToReview) {
            if let food = selectedFood {
                ReviewPage(food: food, user: user)
            }
        }
    }
    
    func activityRow(name: String, amount: Double, venmo: String) -> some View {
        Button {
            sendVenmoRequest(to: venmo, amount: amount, message: "Split from Munch")
        } label: {
            HStack {
                Text("💰 \(name)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)

                Spacer()
                
                Text("$\(String(format: "%.2f", amount))")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.1))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    func sendVenmoRequest(to recipientUsername: String, amount: Double, message: String) {
        NetworkManager.shared.sendVenmoRequest(
            userId: user.id,
            recipientUsername: recipientUsername,
            paymentAmount: amount,
            message: message
        ) { link in
            if let urlString = link, let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            } else {
                print("Failed to get Venmo link.")
            }
        }
    }
}


