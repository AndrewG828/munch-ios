//
//  Login.swift
//  Munch!
//
//  Created by Andrew Gao on 4/25/25.
//

import SwiftUI

struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 24) {
            // MARK: - Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome back!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                Text("Login to continue")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 40)

            // MARK: - Text Fields
            VStack(spacing: 16) {
                TextField("Email or phone", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            .frame(maxWidth: 370)

            // MARK: - Forgot Password
            HStack {
                Spacer()
                Button("Forgot password?") {
                    // action
                }
                .font(.system(size: 14))
            }

            // MARK: - Login Button
            Button(action: {
                // Log in action
            }) {
                Text("Log in")
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(16)
            }
            .frame(maxWidth: 370)

            // MARK: - Sign up
            Spacer()
            Button(action: {
                // Create account action
            }) {
                Text("Not on Munch! yet? Create an account")
                    .font(.footnote)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 32)
    }
}

#Preview {
    Login()
}
