//
//  ConfirmationScreen.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//

import SwiftUI

struct ConfirmationScreen: View {
    
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.15))
                    .frame(width: 120, height: 120)

                Image(systemName: "checkmark")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.green)
            }
            .padding(.bottom, 10)
            .transition(.scale)

            Text("Requests Sent!")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)

            Text("Everyone has been notified to pay you.")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button {
                isPresented = false
            } label: {
                Text("Back to Home")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .cornerRadius(14)
                    .padding(.horizontal, 30)
            }

            Spacer()
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}
