//
//  Message.swift
//  swiftui-chat-app
//
//  Created by Luiza on 04/07/23.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let sender: Sender
}

extension Message {
    enum Sender {
        case user
        case ai
    }
}
