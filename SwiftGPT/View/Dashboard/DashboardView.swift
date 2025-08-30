//
//  DashboardView.swift
//  SwiftGPT
//
//  Created by Owais on 7/30/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var sessionManager: UserSessionManager
    @State private var promptTextField: String = ""
    @State private var isChatViewPresent: Bool = true
    
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {   
        NavigationStack {
            ZStack {
                Color(.systemGray6).ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // HEADER
                    
                    ZStack {
                        Text("Swift-GPT")
                            .font(.system(size: 18, weight: .bold, design: .serif))
                        
                        HStack {
                            Button {
                                //
                            } label: {
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .frame(width: 22, height: 16)
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                        }
                    }.padding(.vertical, 8).padding(.horizontal, 14)
                    
                    if !isChatViewPresent {
                        ScrollView {
                            VStack(spacing: 16) {
                                Image("gpt-logo")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                
                                VStack(spacing: 20) {
                                    Text("Hello, \(sessionManager.userName)!\nI'm ready for help you")
                                        .font(.system(size: 32, weight: .bold))
                                        .multilineTextAlignment(.center)
                                    
                                    Text("Ask me anything what's are on your mind. Am here to assist you! ")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundStyle(Color("gray"))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.top, 14)
                        }
                    } else {
                        VStack {
                            ScrollViewReader { scrollProxy in
                                ScrollView {
                                    LazyVStack(spacing: 8) {
                                        
                                        ContentView()
                                        
                                        ForEach(viewModel.messages) { message in
                                            HStack {
                                                if message.isUser {
                                                    Spacer()
                                                    Text(message.text)
                                                        .padding()
                                                        .background(Color.gray.opacity(0.2))
                                                        .foregroundColor(.black)
                                                        .cornerRadius(20)
                                                        .frame(maxWidth: 250, alignment: .trailing)
                                                } else {
                                                    Text(message.text)
                                                        .foregroundColor(.black)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                    Spacer()
                                                }
                                            }
                                            .padding(.horizontal, 14)
                                        }
                                    }
                                    .padding(.vertical)
                                }
                                .onChange(of: viewModel.messages.count) { _ in
                                    withAnimation {
                                        scrollProxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                                    }
                                }
                            }
                            
                            VStack(spacing: 14) {
                                SuggestionsGridView()
                                
                                HStack(spacing: 10) {
                                    ZStack {
                                        TextField(text: $viewModel.inputText) {
                                            Text("Ask me anything...")
                                        }
                                        .padding(.horizontal)
                                        .keyboardType(.default)
                                    }
                                    .frame(height: 56)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 26))
                                    
                                    Button {
                                        viewModel.sendMessage()
                                    } label: {
                                        Image(systemName: "paperplane.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundStyle(Color("primary"))
                                    }.disabled(viewModel.inputText.isEmpty)
                                    
                                }.padding(.horizontal, 14).padding(.bottom, 14)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(UserSessionManager())
}
