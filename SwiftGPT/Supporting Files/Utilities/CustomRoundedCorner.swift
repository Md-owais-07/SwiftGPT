//
//  CustomRoundedCorner.swift
//  SwiftGPT
//
//  Created by Owais on 7/30/25.
//

import SwiftUI

struct CustomRoundedCorner: Shape {
    var radius: CGFloat = 0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


#Preview {
    CustomRoundedCorner()
}
