//
//  ContentView.swift
//  SwiftGPT
//
//  Created by Owais on 7/30/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sessionManager: UserSessionManager
    
    var body: some View {
        VStack(spacing: 16) {
            Image("gpt-logo")
                .resizable()
                .frame(width: 80, height: 80)
            
            VStack(spacing: 18) {
                Text("Hello, \(sessionManager.userName)! I'm ready for help you")
                    .font(.system(size: 30, weight: .bold, design: .serif))
                    .foregroundStyle(Color.black)
                
                Text("Ask me anything what's are on your mind. Am here to assist you!")
                    .font(.system(size: 16, weight: .regular, design: .serif))
                    .foregroundStyle(Color.gray)
                
            }.multilineTextAlignment(.center)
        }.padding(.horizontal, 14)
    }
}

#Preview {
    ContentView()
        .environmentObject(UserSessionManager())
}























//NavigationSplitView {
//    List {
//        ForEach(items) { item in
//            NavigationLink {
//                Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//            } label: {
//                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//            }
//        }
//        .onDelete(perform: deleteItems)
//    }
//    .toolbar {
//        ToolbarItem(placement: .navigationBarTrailing) {
//            EditButton()
//        }
//        ToolbarItem {
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
//    }
//} detail: {
//    Text("Select an item")
//}
//}
//
//private func addItem() {
//withAnimation {
//    let newItem = Item(timestamp: Date())
//    modelContext.insert(newItem)
//}
//}
//
//private func deleteItems(offsets: IndexSet) {
//withAnimation {
//    for index in offsets {
//        modelContext.delete(items[index])
//    }
//}
//}
//.modelContainer(for: Item.self, inMemory: true)
//@Environment(\.modelContext) private var modelContext
//@Query private var items: [Item]
