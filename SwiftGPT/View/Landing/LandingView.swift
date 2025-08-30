//
//  LandingView.swift
//  SwiftGPT
//
//  Created by Owais on 7/30/25.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("bgclr").ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack {
                            HStack(spacing: 8) {
                                Image("gpt-logo")
                                    .resizable()
                                    .frame(width: 40, height: 45)
                                
                                Text("Swift-GPT")
                                    .font(.system(size: 20, weight: .medium, design: .serif))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 18)
                            
                            Spacer()
                                .frame(height: 52)
                            
                            VStack(alignment: .leading ,spacing: 24) {
                                Text("Start Free\nConversation")
                                    .font(.system(.largeTitle, design: .serif, weight: .bold))
                                
                                VStack(alignment: .leading ,spacing: 8) {
                                    Text("No login required for get started chat with our AI powered chatbot.")
                                    
                                    Text("Feel free to ask what you want to know.")
                                }
                                .font(.system(size: 16, weight: .regular, design: .serif))
                                .foregroundStyle(Color.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                                .frame(height: 66)
                            
                            ZStack {
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 38, height: 26)
                                    .foregroundStyle(Color.white)
                            }
                            .frame(width: 80, height: 80)
                            .background(Color("primary"))
                            .clipShape(.circle)
                            .shadow(color: Color("primary").opacity(0.5), radius: 20)
                        }
                        .padding(.horizontal, 24)
                    }.scrollIndicators(.never)
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 14) {
                            
                            CustomButtonView(title: "Continue With Google", image: "google", bgColor: Color("primary"), textColor: .white) {
                                print("google")
                            }
                            
                            CustomButtonView(title: "Sign Up With Email", image: "mail", bgColor: Color("primary").opacity(0.1), textColor: Color("primary")) {
                                print("Email")
                            }
                            
                            NavigationLink {
                                LoginView()
                            } label: {
                                HStack {
                                    Text("Login To Existing Account")
                                        .font(.system(size: 18, weight: .medium, design: .serif))
                                        .foregroundStyle(Color("primary"))
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 53)
                                .background(Color.white)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color("primary"), lineWidth: 1)
                                }
                            }
                            
                        }
                        .padding([.vertical, .horizontal], 24)
                        .padding(.top, 5)
                        .padding(.bottom, 14)
                    }
                    .background(
                        CustomRoundedCorner(radius: 26, corners: [.topLeft, .topRight])
                            .fill(Color.white)
                    )
                }
            }.ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

#Preview {
    LandingView()
}
