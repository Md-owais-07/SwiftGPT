//
//  LoaderView.swift
//  SwiftGPT
//
//  Created by Owais on 8/1/25.
//

import SwiftUI

struct LoaderView: View {
    var color: Color = .white
    var size: CGFloat = 1.5
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: color))
                .scaleEffect(size)
        }
    }
}


#Preview {
    LoaderView()
}
