//
//  CustomTextField.swift
//  swiftui-chat-app
//
//  Created by Luiza on 07/07/23.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    @ObservedObject var viewModel: ChatViewModel
    @FocusState var focusedTextField: Bool
    
    private let iconSize: CGFloat = 17
    
    var body: some View {
        HStack {
            if text.isEmpty && !focusedTextField {
                Image(systemName: "sparkles")
                    .font(.system(size: iconSize))
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                    .transition(.opacity)
            }
            
            TextField(placeholder, text: $text) { editing in
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.isEditing = editing
                }
            }
            .padding(.horizontal, viewModel.isEditing || !text.isEmpty ? 16 : 0)
            .disabled(viewModel.isRecording)
            .focused($focusedTextField)
            .onReceive(viewModel.$transcriptedMessage) { transcriptedMessage in
                if let transcriptedMessage = transcriptedMessage {
                    focusedTextField = true
                    text = transcriptedMessage
                    viewModel.isEditing = true
                }
            }
            
            if text.isEmpty && !focusedTextField {
                Image(systemName: "mic")
                    .font(.system(size: iconSize))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.trailing, 16)
                    .transition(.opacity)
                    .onTapGesture {
                        viewModel.startRecording()
                    }
            }
        }
    }
}
