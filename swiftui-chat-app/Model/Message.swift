//
//  Message.swift
//  swiftui-chat-app
//
//  Created by Luiza on 04/07/23.
//

import Foundation

struct Message: Codable, Equatable, Identifiable {
    var id = UUID()
    let content: String
    let sender: Sender
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Message {
    enum Sender: Codable {
        case user
        case ai
    }
}
