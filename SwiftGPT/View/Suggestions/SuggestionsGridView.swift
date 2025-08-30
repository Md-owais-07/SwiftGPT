//
//  SuggetionsGridView.swift
//  SwiftGPT
//
//  Created by Owais on 8/4/25.
//

import SwiftUI

struct SuggestionsGridView: View {
    
    let items: [SuggestionModel] = [
        SuggestionModel(title: "Create a code snippet", description: "illustrate how to do something "),
        SuggestionModel(title: "Suggest a recipe", description: "based on my photo"),
        SuggestionModel(title: "Write a text", description: "asking my friend to be my plus-one"),
        SuggestionModel(title: "Tell me a fun fact", description: "about the Roman Empire"),
    ]
    
    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 10) {
                ForEach(items, id: \.self) { item in
                    VStack {
                        Button {
                            
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(item.title)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.black)
                                
                                Text(item.description)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Color("gray"))
                            }.padding([.horizontal, .vertical], 8)
                        }

                    }.background(Color.white).clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }.padding(.horizontal, 14).frame(height: 60)
        }
    }
}

#Preview {
    SuggestionsGridView()
}
