//
//  ReceiptItemCell.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//

import SwiftUI

struct ReceiptItemCell: View {
    var item: ReceiptItem
    
    var body: some View {
        HStack{
            Text(item.name)
            Spacer()
            Text(String(format: "$%0.2f", item.price))
        }
        .font(.system(size: 16, weight: .semibold))
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.gray.opacity(0.1)))
    }
}

