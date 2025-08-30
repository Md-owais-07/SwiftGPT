//
//  ChatViewModel.swift
//  SwiftGPT
//
//  Created by Owais on 8/5/25.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var inputText: String = ""

    private let apiKey = "AIzaSyAnogWJvFav8bJsweNCfmyTqWUFStDXxsQ"

    func sendMessage() {
        let userMessage = ChatMessage(text: inputText, isUser: true)
        messages.append(userMessage)

        let input = inputText
        inputText = ""

        callGeminiAPI(userInput: input)
    }


    private func callGeminiAPI(userInput: String) {
        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=\(apiKey)") else {
            print("Invalid URL")
            return
        }

        let body: [String: Any] = [
            "contents": [
                [
                    "role": "user",
                    "parts": [["text": userInput]]
                ]
            ]
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: body) else {
            print("Failed to encode JSON")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("❌ No data returned")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("✅ Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    print(String(data: data, encoding: .utf8) ?? "Unknown Error")
                }
            }

            do {
                let decoded = try JSONDecoder().decode(GeminiResponse.self, from: data)
                let reply = decoded.candidates.first?.content.parts.first?.text ?? "No response"

                DispatchQueue.main.async {
                    let botMessage = ChatMessage(text: reply, isUser: false)
                    self.messages.append(botMessage)
                }
            } catch {
                print("❌ Decoding error: \(error)")
                print(String(data: data, encoding: .utf8) ?? "")
            }

        }.resume()
    }
}



struct GeminiResponse: Codable {
    struct Candidate: Codable {
        struct Content: Codable {
            struct Part: Codable {
                let text: String
            }
            let parts: [Part]
        }
        let content: Content
    }
    let candidates: [Candidate]
}

