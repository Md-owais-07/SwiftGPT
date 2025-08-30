//
//  ChatMessage.swift
//  SwiftGPT
//
//  Created by Owais on 8/5/25.
//

import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
