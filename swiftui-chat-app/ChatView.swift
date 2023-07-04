//
//  ChatView.swift
//  swiftui-chat-app
//
//  Created by Luiza on 04/07/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject private var viewModel: ChatViewModel
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            InputView(viewModel: viewModel)
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Image("chat-picture")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Good morning, Samantha")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("How can I help you today?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct InputView: View {
    @ObservedObject var viewModel: ChatViewModel
    @State private var message = ""
    
    var body: some View {
        HStack {
            TextField("Ask me anything", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: sendMessage) {
                Text("Send")
                    .foregroundColor(.blue)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
    
    private func sendMessage() {
        viewModel.send(message)
        message = ""
    }
}
