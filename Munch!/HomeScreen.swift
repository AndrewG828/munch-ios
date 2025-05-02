//WHEN ADDING NEW SCREENS SUCH AS THE PROFILE PAGE, MAKE SURE TO ADD A NEW VARIABLE
//THAT IS THE PROFILE OF THE USER, SO YOU CAN PASS IT INTO THE PROFILE PAGE.

import SwiftUI
import UIKit

struct HomeScreen: View {
    @State private var search: String = ""
    @State private var filter = ""
    @State private var showScanPage = false
    @State private var showProfilePage = false
    @State private var showSearch = false
    
    @StateObject private var foodViewModel = FoodViewModel()
    @StateObject private var restaurantViewModel = RestaurantViewModel()
    
    var user: User
    
    var filters: [(String, String)] = [("Location", "Nearby"), ("Trending", "Trending"), ("Friends", "Friends")]
    
    @State private var navBar: String = "Feed"
    var navBarItems: [(String, String)] = [("_Home", "Feed"), ("_Picture", "Scan"), ("_Profile", "Profile")]
    
    let rows = [GridItem()]
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                
                // Title
                Text("Munch!")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.top, 8)
                
                // Search Bar
                Button {
                    showSearch = true
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(width: 15, height: 15)
                        
                        Text("Search stores and products")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.vertical, 11)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 30))
                    .foregroundColor(Color(UIColor.munch.lightGray).opacity(0.8))
                }
                
                // Filter Pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(filters.indices, id: \.self) { index in
                            let filteri = filters[index]
                            Button {
                                filter = filteri.1
                            } label: {
                                HStack {
                                    Image(filteri.0)
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                    
                                    Text(filteri.1)
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal)
                                .foregroundColor(.black)
                                .font(.system(size: 11, weight: .semibold))
                                .background(Capsule())
                                .foregroundColor(Color(UIColor.munch.lightGray).opacity(0.8))
                            }
                        }
                    }
                }
                
                // Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        HStack {
                            Text("Food Near You")
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, spacing: 16) {
                                ForEach(restaurantViewModel.restaurants) { restaurant in
                                    NavigationLink(destination: RestaurantPage(restaurant: restaurant, user: user)){
                                        NearYouCell(restuarant: restaurant)
                                    }
                                }
                            }
                            .frame(height: 110)
                        }
                    }
                    
                    VStack(spacing: 10) {
                        HStack {
                            Text("Food Spotlight")
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                        }
                        
                        LazyVStack(spacing: 25) {
                            ForEach(foodViewModel.foods) { food in
                                NavigationLink(destination: ReviewPage(food: food, user: user)) {
                                    FoodCell(food: food)
                                }
                            }
                        }
                    }
                }
                
                // Bottom Nav Bar
                HStack {
                    ForEach(navBarItems.indices, id: \.self) { index in
                        let navBari = navBarItems[index]
                        let isSelected = navBar == navBari.1
                        let imageName = (isSelected ? "Select" : "Unselect") + navBari.0
                        
                        Button {
                            navBar = navBari.1
                            if navBar == "Scan" {
                                showScanPage = true
                            } else if navBar == "Profile" {
                                showProfilePage = true
                            }
                        } label: {
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                
                                Text(navBari.1)
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundColor(isSelected ? .black : .gray)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.bottom, 8)
                .padding(.top)
                .frame(height: 20)
            }
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal, 35)
            .sheet(isPresented: $showScanPage) {
                ScanPage(isPresented: $showScanPage)
            }
            .navigationDestination(isPresented: $showProfilePage) {
                ProfilePage(user: user)
            }
            .sheet(isPresented: $showSearch) {
                SearchScreen(user: user)
            }
            .onAppear{
                foodViewModel.getAllFoods()
            }
            .onAppear {
                restaurantViewModel.fetchRestaurants()
            }
    }
}

#Preview {
    HomeScreen(user: User(id: 1, username: "Andrew", email: "asd", phone: 123, venmo: "hi"))
}
