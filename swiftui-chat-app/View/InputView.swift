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
                if viewModel.isSending {
                    ProgressView()
                        .padding(.horizontal, 8)
                } else {
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        
        if viewModel.isRecording {
            recordingView()
        }
    }
    
    private func calculateCircleDimension(_ value: Float) -> CGFloat {
        let clampedValue = CGFloat(min(max(value, 0), 160))
        return max(clampedValue, 80)
    }
    
    private func recordingView() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(height: 200)
            VStack {
                Circle()
                    .fill(Color.black.opacity(0.1))
                    .frame(width: calculateCircleDimension(viewModel.currentAudioLevel * 200),
                           height: calculateCircleDimension(viewModel.currentAudioLevel * 200))
                    .animation(.easeInOut, value: viewModel.currentAudioLevel)
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
    
    private func sendMessage() {
        viewModel.send(message)
        message = ""
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        let service = MockChatService()
        let viewModel = ChatViewModel(service: service)
        InputView(viewModel: viewModel)
    }
}
