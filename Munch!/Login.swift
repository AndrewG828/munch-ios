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
        VStack (alignment: .leading){
            Text("Welcome back!")
                .font(.title)
                .fontWeight(.bold)
            
            
            TextField(
                "Email or phone",
                text: $username
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            .frame(maxWidth: 370)
            .frame(maxWidth: .infinity, alignment: .center)
            
            TextField(
                "Password",
                text: $password
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            .frame(maxWidth: 370)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Button{} label: {
                Text("Forgot password?")
            }
            .padding(.bottom)
            
            HStack {
                Spacer()
                
                Button {}
                label: {
                    Text("Log in")
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 50)
                }
                .background(
                    Capsule()
                        .foregroundColor(.gray)
                )
                
                Spacer()
            }
            
            
            Button{}
            label: {
                Text("Not on Munch! yet? Create an account")
            }
        }
    }
}

#Preview {
    Login()
}
