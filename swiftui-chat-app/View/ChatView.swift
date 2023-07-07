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

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        let service = MockChatService()
        ChatView(viewModel: ChatViewModel(service: service))
    }
}
