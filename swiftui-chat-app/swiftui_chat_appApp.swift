//
//  swiftui_chat_appApp.swift
//  swiftui-chat-app
//
//  Created by Luiza on 04/07/23.
//

import SwiftUI

@main
struct swiftui_chat_appApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView(viewModel: ChatViewModel())
        }
    }
}
