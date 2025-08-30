//
//  CustomButtonView.swift
//  SwiftGPT
//
//  Created by Owais on 7/30/25.
//

import SwiftUI

struct CustomButtonView: View {
    let title: String
    var image: String = ""
    var isImageOnLeft: Bool = true
    var bgColor: Color = Color("primay")
    var textColor: Color = Color.white
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            HStack(spacing: 10) {
                
                if isImageOnLeft {
                    Image(image)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    Text(title)
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        .foregroundStyle(textColor)
                } else {
                    Text(title)
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        .foregroundStyle(textColor)
                }
                
//                Text(title)
//                    .font(.system(size: 18, weight: .medium, design: .serif))
//                    .foregroundStyle(textColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56).background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    CustomButtonView(title: "Google", image: "google", action: {})
}
