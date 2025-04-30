//
//  SignUp.swift
//  Munch!
//
//  Created by Andrew Gao on 4/29/25.
//

import SwiftUI

struct SignUp: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Sign Up")
                .font(.system(size: 28, weight: .bold, design: .rounded))
            Text("Username")
            TextField("Enter your username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            Text("Password")
            SecureField("Enter your password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            Button{
                
            }
            label: {
                Text("Sign Up")
                    .foregroundColor(Color(.white))
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .padding(.vertical, 11)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal, 35)
        
    }
}

#Preview {
    SignUp()
}
