//
//  Login.swift
//  Munch!
//
//  Created by Andrew Gao on 4/25/25.
//

import SwiftUI
import Foundation

//------------------------------------------------------------------------------------
struct SplashScreenView: View {
    @State private var animationState = 0
    @State private var isAnimating = false
    @State private var showMainContent = false
    @State private var textScale = 0.8
    @State private var textOpacity = 0.0
    @State private var backgroundOpacity = 1.0
    @State private var showText = true
    
    var mainContentView: AnyView
    
    // Animation timing constants
    private let initialDelay = 0.5
    private let textAppearDuration = 0.4
    private let crushDelay = 0.8
    private let jawAnimationDuration = 0.4
    private let finishDelay = 0.1
    
    // Colors
    private let backgroundColor = Color(hex: "FAE1AD")
    private let jawColor = Color(hex: "DBC2EE")
    
    init(mainContentView: AnyView) {
        self.mainContentView = mainContentView
    }
    
    var body: some View {
        ZStack {
            if showMainContent {
                mainContentView
                    .transition(.opacity)
            } else {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .opacity(backgroundOpacity)
                    .animation(.easeOut(duration: 0.2), value: backgroundOpacity)

                ZStack {
                    if showText {
                        Text("Munch!")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.black)
                            .opacity(textOpacity)
                            .scaleEffect(textScale)
                            .animation(.easeInOut(duration: textAppearDuration), value: textOpacity)
                            .animation(.easeInOut(duration: textAppearDuration), value: textScale)
                            .zIndex(2)
                    }
                    
                    // Top jaw
                    VStack(spacing: 0) {
                        jawColor
                            .frame(height: animationState == 0 ? 0 : (animationState >= 1 && animationState < 3 ? UIScreen.main.bounds.height/2 : 0))
                            .animation(.easeOut(duration: jawAnimationDuration), value: animationState)
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.top)
                    .zIndex(4)
                    
                    // Bottom jaw
                    VStack(spacing: 0) {
                        Spacer()
                        jawColor
                            .frame(height: animationState == 0 ? 0 : (animationState >= 1 && animationState < 3 ? UIScreen.main.bounds.height/2 : 0))
                            .animation(.easeOut(duration: jawAnimationDuration), value: animationState)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .zIndex(4)
                }
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    func startAnimation() {
        isAnimating = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: textAppearDuration)) {
                textOpacity = 1.0
                textScale = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + textAppearDuration + initialDelay) {
                withAnimation {
                    animationState = 1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + crushDelay * 0.5) {
                    withAnimation(.easeOut(duration: 0.25)) {
                        textScale = 0.8
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + crushDelay * 0.3) {
                        withAnimation(.easeOut(duration: 0.01)) {
                            textOpacity = 0
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + crushDelay) {
                    showText = false
                    withAnimation(.easeOut(duration: 0.01)) {
                        backgroundOpacity = 0.0 // Set to 0% opacity
                    }
                    
                    withAnimation(.easeOut(duration: jawAnimationDuration)) {
                        animationState = 3
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeIn(duration: 0.2)) {
                            showMainContent = true
                        }
                    }
                }
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
//------------------------------------------------------------------------------------
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
