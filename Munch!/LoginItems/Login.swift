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
        VStack {
            VStack(spacing: 24){
                // MARK: - Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back!")
                        .font(.system(size: 28, weight: .bold))
                    Text("Login to continue")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .bold))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 120)
                .padding(.bottom)
                
                // MARK: - Text Fields
                VStack(spacing: 16) {
                    TextField("Email or phone", text: $username)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 9)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .font(.system(size: 14))
                    
                    SecureField("Password", text: $password)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 9)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .font(.system(size: 14))
                }
                .frame(maxWidth: 380)
                
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
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .padding(.vertical, 11)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.munch.beige))
                        .cornerRadius(12)
                }
                .frame(maxWidth: 380)
            }
            .padding(.top, 80)
            
            Spacer()

            // MARK: - Sign up
            NavigationLink(destination: SignUp()) {
                Text("Not on Munch! yet? Create an account")
                    .font(.footnote)
                    .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal, 35)
        .padding(.bottom, 32)
    }
}

#Preview {
    Login()
}
