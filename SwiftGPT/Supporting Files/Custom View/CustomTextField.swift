//
//  CustomTextField.swift
//  SwiftGPT
//
//  Created by Owais on 7/30/25.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let image: String
    var isSecure: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.system(size: 18, weight: .medium, design: .serif))
                .foregroundStyle(Color("gray"))
            
            VStack {
                if isSecure {
                    ZStack {
                        HStack(spacing: 12) {
                            Image(image)
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        
                        SecureField(placeholder, text: $text)
                            .multilineTextAlignment(.leading)
                            .frame(height: 56)
                            .padding(.leading, 50)
                            .padding(.trailing, 14)
                            .cornerRadius(12)
                    }
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("gray"), lineWidth: 1)
                            .fill(Color.clear)
                    }
                } else {
                    ZStack {
                        HStack(spacing: 12) {
                            Image(image)
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        
                        TextField(placeholder, text: $text)
                            .multilineTextAlignment(.leading)
                            .frame(height: 56)
                            .padding(.leading, 50)
                            .padding(.trailing, 14)
                            .cornerRadius(12)
                    }
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("gray"), lineWidth: 1)
                            .fill(Color.clear)
                    }
                }
            }
            
        }
    }
}

#Preview {
    CustomTextField(text: .constant(""), title: "Email", placeholder: "Enter you email", image: "mail2")
}
