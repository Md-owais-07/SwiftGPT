//
//  LoadingViewModifier.swift
//  SwiftGPT
//
//  Created by Owais on 8/1/25.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    let isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                LoaderView()
            }
        }
    }
}

extension View {
    func loading(_ isLoading: Bool) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
