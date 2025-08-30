//
//  RegisterView.swift
//  SwiftGPT
//
//  Created by Owais on 7/30/25.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var sessionManager: UserSessionManager
    
    var body: some View {
        ZStack {
            Color("bgclr").ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .leading ,spacing: 18) {
                    Text("Create an account")
                        .font(.system(.title, design: .serif, weight: .bold))
                    
                    VStack(alignment: .leading ,spacing: 8) {
                        Text("Sign for a free account. Get easier than search engines results.")
                    }
                    .font(.system(size: 16, weight: .regular, design: .serif))
                    .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 45)
                
                VStack(spacing: 8) {
                    VStack(spacing: 28) {
                        CustomTextField(text: $viewModel.nameTextField, title: "Name", placeholder: "Enter your name", image: "person", isSecure: false)
                        
                        CustomTextField(text: $viewModel.emailTextField, title: "Email", placeholder: "Enter your email", image: "mail2", isSecure: false)
                        
                        CustomTextField(text: $viewModel.passwordTextField, title: "Password", placeholder: "Create strong password", image: "pass", isSecure: true)
                    }
                }
                
                Spacer()
                    .frame(height: 40)
                
                VStack(spacing: 24) {
                    
                    VStack {
                        CustomButtonView(title: "Create Account", isImageOnLeft: false, bgColor: Color("primary")) {
                            if viewModel.emailTextField.isEmpty || viewModel.passwordTextField.isEmpty || viewModel.nameTextField.isEmpty {
                                print("All fields are required")
                            } else if !viewModel.emailTextField.contains("@") {
                                print("Enter valid email")
                            } else if viewModel.passwordTextField.count < 6 {
                                print("Password should be atleast 6 characters")
                            } else {
                                viewModel.createUser(email: viewModel.emailTextField, password: viewModel.passwordTextField) { result in
                                    if result {
                                        print("USER REGISTRATION SUCCESS", result)
                                        if let uid = Auth.auth().currentUser?.uid {
                                            viewModel.createUserProfile(uid: uid, name: viewModel.nameTextField, email: viewModel.emailTextField) { profileResult in
                                                DispatchQueue.main.async {
                                                    if profileResult {
                                                        print("USER PROFILE CREATED IN FIRESTORE", profileResult)
                                                        sessionManager.isLoggedIn = true
                                                        sessionManager.userName = viewModel.nameTextField
                                                        sessionManager.userEmail = viewModel.emailTextField
                                                    } else {
                                                        print("FAILED TO SAVE USER PROFILE IN FIRESTORE.")
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        print("ERROR USER REGISTRATION")
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .foregroundStyle(Color.black.opacity(0.8))
                        
                        Button {
                            dismiss()
                        } label: {
                            Text("Login")
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
    RegisterView()
}
