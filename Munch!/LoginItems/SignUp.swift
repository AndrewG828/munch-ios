//
//  SignUp.swift
//  Munch!
//
//  Created by Andrew Gao on 4/29/25.
//

import SwiftUI
import PhotosUI
import GoogleSignIn

struct SignUp: View {
    @StateObject private var userViewModel = UserViewModel()
    
    @State private var profileImage: Image? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    @State private var shouldNavigate = false
    
    var body: some View {
            VStack (alignment: .leading, spacing: 40) {
                Spacer()
                
                Text("Sign Up")
                    .font(.system(size: 32, weight: .bold))
                
                HStack{
                    Spacer()
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        ZStack(alignment: .bottomTrailing) {
                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image("User")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    )
                            }
                            
                            // Plus icon
                            ZStack {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 35, height: 35)
                                Image("Plus")
                            }
                            .offset(x: 2, y: -8)
                        }
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                self.imageData = data
                                self.profileImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                VStack (alignment: .leading, spacing: 16){
                    TextField("Enter your username", text: $userViewModel.username)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 9)
                        .overlay( RoundedRectangle(cornerRadius: 12).stroke(Color(UIColor.systemGray4), lineWidth: 1))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .font(.system(size: 14))
                    
                    SecureField("Enter your password", text: $userViewModel.password)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 9)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(UIColor.systemGray4), lineWidth: 1))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .font(.system(size: 14))
                }
                VStack(spacing: 16) {
                    //Sign up button
                    Button{
                        userViewModel.createUser {
                            if let imageData = imageData {
                                    userViewModel.user?.profileImage = imageData
                                }
                            withAnimation {
                                shouldNavigate = true
                            }
                        }
                    }
                    label: {
                        Text("Sign Up")
                            .foregroundColor(Color(.gray))
                            .font(.system(size: 12, weight: .semibold))
                            .padding(.vertical, 11)
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.munch.beige))
                            .cornerRadius(12)
                    }
                    
                    //"or" divider
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        Text("or")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                    
                    //Sign in with google button
                    HStack{
                        Spacer()
                        
                        Button {
                            handleSignupButton()
                        }label: {
                            HStack{
                                Image("Google")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                Text("Sign in with Google")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(.vertical, 11)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(UIColor.systemGray4), lineWidth: 1))
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                        }
                        
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 35)
            .padding(.bottom, 135)
            
            .navigationDestination(isPresented: $shouldNavigate) {
                if let user = userViewModel.user {
                    HomeScreen(user: user)
                } else {
                    HomeScreen(user: nil)
                }
            }
    }
    
    func handleSignupButton() {
        print("Sign in with google clicked")
        
        if let rootViewController = getRootViewControll() {
            GIDSignIn.sharedInstance.signIn(
                withPresenting: rootViewController
            ) {
                signInResult, error in
                guard let result = signInResult else {
                    return
                }
                userViewModel.username = result.user.profile?.name ?? ""
                userViewModel.createUser {
                    withAnimation {
                        shouldNavigate = true
                    }
                }
                print(result.user.profile?.imageURL(withDimension: 20))
            }
        }
    }
}

#Preview {
    SignUp()
}

func getRootViewControll() -> UIViewController? {
    guard let scene = UIApplication.shared.connectedScenes.first as?
            UIWindowScene,
          let rootViewController = scene.windows.first?.rootViewController else {
        return nil
    }
    return getVisibleViewController(from: rootViewController)
}

private func getVisibleViewController(from vc: UIViewController) ->
UIViewController {
    if let nav = vc as? UINavigationController {
        return getVisibleViewController(from: nav.visibleViewController!)
    }
    if let tab = vc as? UITabBarController {
        return getVisibleViewController(from: tab.selectedViewController!)
    }
    if let presented = vc.presentedViewController {
        return getVisibleViewController(from: presented)
    }
    return vc
}
