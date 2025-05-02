//
//  SplitBillScreen.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//
import SwiftUI

struct SplitBillScreen: View {
    
    var items: [ReceiptItem]
    var tax: Float
    var tips: Float
    var paymentTotal: Float
    
    @Binding var isPresented: Bool
    
    @State var navigateConfirmation = false
    @State private var showAssignScreen = false
    @State private var selectedFoodName = ""
    @State private var assignments: [String: [String]] = [:]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack{
                HStack{
                    Text("Split The Bill")
                        .font(.system(size: 28, weight: .heavy))
                    Spacer()
                }
                .padding(.bottom, 2)
                
                HStack{
                    Text("Select an item you would like to assign")
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            
            ScrollView (.vertical, showsIndicators: false){
                VStack (spacing: 16){
                    ForEach(items, id: \.self) { item in
                        VStack(alignment: .leading, spacing: 6) {
                            Button {
                                selectedFoodName = item.name
                                showAssignScreen = true
                            } label: {
                                ReceiptItemCell(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())

                            if let assigned = assignments[item.name], !assigned.isEmpty {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(assigned, id: \.self) { name in
                                            Text(name)
                                                .font(.system(size: 12, weight: .medium))
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 5)
                                                .background(Color.blue.opacity(0.1))
                                                .foregroundColor(.blue)
                                                .clipShape(Capsule())
                                        }
                                    }
                                    .padding(.horizontal, 4)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: 320)
            
            HStack{
                VStack (spacing: 16){
                    HStack{
                        Text("Tax")
                        Spacer()
                        Text(String(format: "$%0.2f", tax))
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .padding()
                    .frame(width: 151)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.1)))
                    
                    HStack{
                        Text("Tips")
                        Spacer()
                        Text(String(format: "$%0.2f", tips))
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .padding()
                    .frame(width: 151)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.1)))
                }
                
                Spacer()
                
                HStack{
                    Text("Total")
                    Spacer()
                    Text(String(format: "$%0.2f", paymentTotal))
                }
                .font(.system(size: 16, weight: .semibold))
                .padding()
                .frame(width: 151)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.munch.beige).opacity(0.6)))
                
            }
            .padding(.bottom, 21)
            
            Button {
                
            }label: {
                Text("Split Evenly")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.munch.beige).opacity(0.6)))
            }
            
            Button {
                navigateConfirmation = true
            }label: {
                Text("Split!")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.munch.beige).opacity(0.6)))
            }
            
        }
        .padding(.horizontal, 35)
        .navigationDestination(isPresented: $navigateConfirmation) {
            ConfirmationScreen(isPresented: $isPresented)
        }
        .sheet(isPresented: $showAssignScreen) {
            AssignFriendsScreen(foodName: selectedFoodName) { selectedFriends in
                assignments[selectedFoodName] = selectedFriends
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

