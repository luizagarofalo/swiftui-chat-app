//
//  MessageView.swift
//  swiftui-chat-app
//
//  Created by Luiza on 10/07/23.
//

import SwiftUI

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

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(content: "Hello", sender: .user))
    }
}
