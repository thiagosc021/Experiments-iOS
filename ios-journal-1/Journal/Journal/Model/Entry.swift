//
//  Entry.swift
//  Journal
//
//  Created by Thiago Costa on 3/29/22.
//

import Foundation

class Entry: Equatable {
    
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        lhs.title == rhs.title && lhs.body == rhs.body && lhs.timeStamp == lhs.timeStamp
    }
    
    var title: String
    var body: String
    var timeStamp: Date
    
    init(title: String, body: String, timeStamp: Date = Date() ) {
        self.title = title
        self.body = body
        self.timeStamp = timeStamp
    }
}
