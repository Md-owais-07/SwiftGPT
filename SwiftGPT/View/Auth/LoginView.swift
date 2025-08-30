//
//  LoginView.swift
//  SwiftGPT
//
//  Created by Owais on 7/30/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var isLoading = false
    @EnvironmentObject var sessionManager: UserSessionManager
    
    var body: some View {
        ZStack {
            Color("bgclr").ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading ,spacing: 18) {
                    Text("Welcome back to login!")
                        .font(.system(.title, design: .serif, weight: .bold))
                    
                    VStack(alignment: .leading ,spacing: 8) {
                        Text("Login to your account. Get easier than search engines results.")
                    }
                    .font(.system(size: 16, weight: .regular, design: .serif))
                    .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 45)
                
                VStack(spacing: 8) {
                    VStack(spacing: 28) {
                        CustomTextField(text: $viewModel.emailTextField, title: "Email", placeholder: "Enter your email", image: "mail2", isSecure: false)
                        
                        CustomTextField(text: $viewModel.passwordTextField, title: "Password", placeholder: "Enter your password", image: "pass", isSecure: true)
                    }
                    
                    HStack {
                        Text("")
                        
                        Spacer()
                        
                        Button {
                            //
                        } label: {
                            Text("Reset password")
                                .font(.system(size: 15, weight: .regular, design: .serif))
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 40)
                
                VStack(spacing: 24) {
                    
                    VStack(spacing: 20) {
                        CustomButtonView(title: "Login", isImageOnLeft: false, bgColor: Color("primary")) {
                            if viewModel.emailTextField.isEmpty || viewModel.passwordTextField.isEmpty {
                                print("Email and Password fields are required")
                            } else if !viewModel.emailTextField.contains("@") {
                                print("Enter valid email")
                            } else if viewModel.passwordTextField.count < 6 {
                                print("Password should be atleast 6 characters")
                            } else {
                                viewModel.loginWithFirebase(email: viewModel.emailTextField, password: viewModel.passwordTextField) { result in
                                    if result {
                                        print("USER LOGIN SUCCESS", result)
                                        
                                        if let uid = Auth.auth().currentUser?.uid {
                                            print("GET CURRENT USER ID: \(uid)")
                                            viewModel.fetchUserProfile(uid: uid) { userProfile in
                                                DispatchQueue.main.async {
                                                    if let profile = userProfile {
                                                        print("USER PROFILE FETCHED SUCCESSFULLY: \(uid)", profile)
                                                        sessionManager.isLoggedIn = true
                                                        sessionManager.userName = profile.name
                                                        sessionManager.userEmail = profile.email
                                                    } else {
                                                        print("FAILED TO FETCH USER PROFILE")
                                                    }
                                                }
                                            }
                                        } else {
                                            print("FAILED TO FECTH USER ID")
                                        }
                                    } else {
                                        print("USER LOGIN FAILED")
                                    }
                                }
                            }
                        }
                        
                        Text("Or sign in with using")
                            .font(.system(size: 16, weight: .regular, design: .serif))
                            .foregroundStyle(Color.black.opacity(0.6))
                        
                        Button {
                            //
                        } label: {
                            HStack {
                                Text("Login To Existing Account")
                                    .font(.system(size: 18, weight: .medium, design: .serif))
                                    .foregroundStyle(Color("primary"))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 53).background(Color.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("primary") ,lineWidth: 1)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Don’t have an account?")
                            .foregroundStyle(Color.black.opacity(0.8))
                        
                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Create an account")
                                .foregroundStyle(Color("primary"))
                        }
                    }
                    .font(.system(size: 16, weight: .medium, design: .serif))
                }
            }
            .navigationBarBackButtonHidden(true)
            .background(EnableSwipeBackGesture())
            .padding(.horizontal, 24)
            if viewModel.isLoading {
                LoaderView()
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    LoginView()
}
