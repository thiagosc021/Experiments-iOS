//
//  Journal.swift
//  Journal
//
//  Created by Thiago Costa on 3/31/22.
//

import Foundation

class Journal: Codable {
    var title: String
    var entries: [Entry]
    
    init(title: String, entries:[Entry] = [Entry]()) {
        self.title = title
        self.entries = entries
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        lhs.title == rhs.title && lhs.entries == rhs.entries
    }
}
