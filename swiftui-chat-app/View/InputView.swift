//
//  InputView.swift
//  swiftui-chat-app
//
//  Created by Luiza on 07/07/23.
//

import SwiftUI

struct InputView: View {
    @ObservedObject var viewModel: ChatViewModel
    @State private var message = ""
    
    var body: some View {
        HStack {
            CustomTextField(
                placeholder: "Ask me anything",
                text: $message,
                viewModel: viewModel
            )
            .frame(height: 40)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(100)
            
            if viewModel.isEditing || viewModel.isRecording {
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        
        if viewModel.isRecording {
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 200)
                VStack {
                    Circle()
                        .fill(Color.black.opacity(0.1))
                        .frame(width: 80, height: 80)
                        .padding()
                }
                Text("Tap to stop recording")
                    .foregroundColor(.white)
                    .font(.headline)
                    .onTapGesture {
                        viewModel.stopRecording()
                    }
            }
        }
    }
    
    private func sendMessage() {
        viewModel.send(message)
        viewModel.isEditing = false
        message = ""
        hideKeyboard()
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        let service = MockChatService()
        let viewModel = ChatViewModel(service: service)
        InputView(viewModel: viewModel)
    }
}
