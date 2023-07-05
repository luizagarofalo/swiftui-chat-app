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
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.messages) { message in
                            MessageView(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                    .onChange(of: viewModel.messages) { _ in
                        proxy.scrollTo(viewModel.messages.last?.id)
                    }
                }
            }
            
            InputView(viewModel: viewModel)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.05), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
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

struct MessageView: View {
    var message: Message
    
    var body: some View {
        HStack {
            if message.sender == .user {
                Spacer()
            }
            
            Text(message.content)
                .padding()
                .font(.system(size: 17))
                .foregroundColor(message.sender == .user ? Color.white : Color.black)
                .background(message.sender == .user ? Color.blue.opacity(0.7) : Color.blue.opacity(0.05))
                .cornerRadius(10, corners: message.sender == .user
                              ? [.topLeft, .topRight, .bottomLeft]
                              : [.topLeft, .topRight, .bottomRight])
            
            if message.sender == .ai {
                Spacer()
            }
        }
    }
}

struct InputView: View {
    @ObservedObject var viewModel: ChatViewModel
    @State private var isEditing = false
    @State private var message = ""
    
    var body: some View {
        HStack {
            ChatTextField(
                placeholder: "Ask me anything",
                text: $message,
                isEditing: $isEditing
            )
            .frame(height: 40)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(100)
            
            if isEditing {
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    
    private func sendMessage() {
        viewModel.send(message)
        message = ""
        isEditing = false
        hideKeyboard()
    }
}

struct ChatTextField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var isEditing: Bool
    
    private let iconSize: CGFloat = 17
    
    var body: some View {
        HStack {
            if text.isEmpty && !isEditing {
                Image(systemName: "sparkles")
                    .font(.system(size: iconSize))
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                    .transition(.opacity)
            }
            
            TextField(placeholder, text: $text) { editing in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isEditing = editing
                }
            }
            .textFieldStyle(PlainTextFieldStyle())
            .padding(.horizontal, isEditing ? 16 : 0)
            
            if text.isEmpty && !isEditing {
                Image(systemName: "mic")
                    .font(.system(size: iconSize))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.trailing, 16)
                    .transition(.opacity)
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        let service = MockChatService()
        ChatView(viewModel: ChatViewModel(service: service))
    }
}
