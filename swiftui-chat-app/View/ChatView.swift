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

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        let service = MockChatService()
        ChatView(viewModel: ChatViewModel(service: service))
    }
}
