//
//  HeaderView.swift
//  swiftui-chat-app
//
//  Created by Luiza on 07/07/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image("chat-picture")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Good morning, Samantha")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("How can I help you today?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
