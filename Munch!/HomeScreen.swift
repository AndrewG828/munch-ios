//
//  HomeScreen.swift
//  Munch!
//
//  Created by Andrew Gao on 4/29/25.
//

//import SwiftUI
//struct HomeScreen: View {
//    @State private var search: String = ""
//
//    @State private var filter = ""
//    private var filters: [(String, String)] = [("Location","Nearby"), ("Trending","Trending"), ("Friends","Friends")]
//    
//    @State private var navBar: String = "Feed"
//    private var navBarItems: [(String, String)] = [("_Home", "Feed"), ("_Picture", "Scan"), ("_Profile", "Profile")]
//    
//    let rows = [
//        GridItem()
//    ]
//    
//    var body: some View {
//        NavigationView{
//            VStack (alignment: .leading, spacing: 16) {
//                Text("Munch!")
//                    .font(.system(size: 30, weight: .bold))
//                
//                //Search Bar
//                Button {
//                    
//                }label: {
//                    HStack{
//                        Image(systemName: "magnifyingglass")
//                            .resizable()
//                            .fontWeight(.medium)
//                            .foregroundColor(.black)
//                            .frame(width: 15, height: 15)
//                        
//                        Text("Search stores and products")
//                            .font(.system(size: 14, weight: .medium))
//                            .foregroundColor(.black)
//                        
//                        Spacer()
//                    }
//                    .padding(.leading)
//                    .padding(.vertical, 11)
//                    .frame(maxWidth: .infinity)
//                    .background(RoundedRectangle(cornerRadius: 30))
//                    .foregroundColor(Color(UIColor.munch.lightGray).opacity(0.8))
//                }
//                
//                //            TextField("Search stores and products", text: $search)
//                //                .padding()
//                //                .background(Color(.systemGray6))
//                
//                //Filter pills
//                ScrollView (.horizontal, showsIndicators: false){
//                    HStack {
//                        ForEach (filters.indices, id: \.self) {index in
//                            let filteri = filters[index]
//                            Button {
//                                filter = filteri.1
//                            }label: {
//                                HStack {
//                                    Image(filteri.0)
//                                        .resizable()
//                                        .frame(width: 18, height: 18)
//                                    
//                                    Text(filteri.1)
//                                }
//                                .padding(.vertical, 12)
//                                .padding(.horizontal)
//                                .foregroundColor(.black)
//                                .font(.system(size: 11, weight: .semibold))
//                                .background(Capsule())
//                                .foregroundColor(Color(UIColor.munch.lightGray).opacity(0.8))
//                            }
//                        }
//                    }
//                }
//                
//                //Food near you and Food spot light scrollview
//                ScrollView(.vertical, showsIndicators: false){
//                    VStack (spacing: 10){
//                        HStack{
//                            Text("Food Near You")
//                                .font(.system(size: 18, weight: .bold))
//                            
//                            Spacer()
//                        }
//                        
//                        ScrollView(.horizontal, showsIndicators: false){
//                            LazyHGrid(rows: rows, spacing: 16) {
//                                ForEach(Restaurant.dummyData) { restaurant in
//                                    NearYouCell(restuarant: restaurant)
//                                }
//                            }
//                            .frame(height: 110)
//                        }
//                    }
//                    
//                    VStack (spacing: 10) {
//                        HStack{
//                            Text("Food Spotlight")
//                                .font(.system(size: 18, weight: .bold))
//                            Spacer()
//                        }
//                        
//                        LazyVStack (spacing: 25) {
//                            ForEach(Food.dummyData) { food in
//                                NavigationLink (destination: ReviewPage(food: food)) {
//                                    FoodCell(food: food)
//                                }
//                            }
//                        }
//                        .padding(.trailing)
//                    }
//                }
//                
//                HStack {
//                    ForEach(navBarItems.indices, id: \.self) { index in
//                        let navBari = navBarItems[index]
//                        let isSelected = navBar == navBari.1
//                        let imageName = (isSelected ? "Select" : "Unselect") + navBari.0
//                        
//                        Button {
//                            navBar = navBari.1
//                        } label: {
//                            VStack {
//                                Image(imageName)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 32, height: 32)
//                                Text(navBari.1)
//                                    .font(.system(size: 10, weight: .semibold))
//                                    .foregroundColor(isSelected ? .black : .gray)
//                            }
//                            .frame(maxWidth: .infinity)
//                        }
//                    }
//                }
//                .padding(.top)
//                .frame(height: 20)
//            }
//            .padding(.horizontal, 35)
//        }
//    }
//}

import SwiftUI

struct HomeScreen: View {
    @State private var search: String = ""
    @State private var filter = ""
    @State private var showScanPage = false // New state to control ScanPage presentation
    
    private var filters: [(String, String)] = [("Location","Nearby"), ("Trending","Trending"), ("Friends","Friends")]
    
    @State private var navBar: String = "Feed"
    private var navBarItems: [(String, String)] = [("_Home", "Feed"), ("_Picture", "Scan"), ("_Profile", "Profile")]
    
    let rows = [
        GridItem()
    ]
    
    var body: some View {
        NavigationView{
            VStack (alignment: .leading, spacing: 16) {
                Text("Munch!")
                    .font(.system(size: 30, weight: .bold))
                
                //Search Bar
                Button {
                    
                }label: {
                    HStack{
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
                
                //Filter pills
                ScrollView (.horizontal, showsIndicators: false){
                    HStack {
                        ForEach (filters.indices, id: \.self) {index in
                            let filteri = filters[index]
                            Button {
                                filter = filteri.1
                            }label: {
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
                
                //Food near you and Food spot light scrollview
                ScrollView(.vertical, showsIndicators: false){
                    VStack (spacing: 10){
                        HStack{
                            Text("Food Near You")
                                .font(.system(size: 18, weight: .bold))
                            
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHGrid(rows: rows, spacing: 16) {
                                ForEach(Restaurant.dummyData) { restaurant in
                                    NearYouCell(restuarant: restaurant)
                                }
                            }
                            .frame(height: 110)
                        }
                    }
                    
                    VStack (spacing: 10) {
                        HStack{
                            Text("Food Spotlight")
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                        }
                        
                        LazyVStack (spacing: 25) {
                            ForEach(Food.dummyData) { food in
                                NavigationLink (destination: ReviewPage(food: food)) {
                                    FoodCell(food: food)
                                }
                            }
                        }
                        .padding(.trailing)
                    }
                }
                
                HStack {
                    ForEach(navBarItems.indices, id: \.self) { index in
                        let navBari = navBarItems[index]
                        let isSelected = navBar == navBari.1
                        let imageName = (isSelected ? "Select" : "Unselect") + navBari.0
                        
                        Button {
                            navBar = navBari.1
                            
                            // Handle navigation when "Scan" is selected
                            if navBari.1 == "Scan" {
                                showScanPage = true
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
                .padding(.top)
                .frame(height: 20)
            }
            .padding(.horizontal, 35)
            .sheet(isPresented: $showScanPage) {
                ScanPage()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
