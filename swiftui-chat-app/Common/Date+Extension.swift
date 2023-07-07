//
//  Date+Extension.swift
//  swiftui-chat-app
//
//  Created by Luiza on 07/07/23.
//

import Foundation

extension Date {
    func toString(dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
