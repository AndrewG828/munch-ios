//
//  SplitBillScreen.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//
import SwiftUI

struct SplitBillScreen: View {
    
    var items: [ReceiptItem]
    
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
                        ReceiptItemCell(item: item)
                    }
                }
            }
            .frame(maxHeight: 320)
            
            HStack{
                VStack (spacing: 16){
                    HStack{
                        Text("Tax")
                        Spacer()
                        Text(String(format: "$%0.2f", 5.50))
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .padding()
                    .frame(width: 151)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.1)))
                    
                    HStack{
                        Text("Tips")
                        Spacer()
                        Text(String(format: "$%0.2f", 8.00))
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
                    Text(String(format: "$%0.2f", 80.55))
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
            
        }
        .padding(.horizontal, 35)
        .navigationBarBackButtonHidden(true)
    }
}

