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
    @Binding var isEditing: Bool
    @Binding var isRecording: Bool
    
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
            .disabled(isRecording)
            
            if text.isEmpty && !isEditing {
                Image(systemName: "mic")
                    .font(.system(size: iconSize))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.trailing, 16)
                    .transition(.opacity)
                    .onTapGesture {
                        isRecording = true
                    }
            }
        }
    }
}
