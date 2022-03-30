//
//  EntryModelController.swift
//  Journal
//
//  Created by Thiago Costa on 3/29/22.
//

import Foundation

enum EntryModelControllerError: Error {
    case entryNotFound
    case titleIsToLarge
    case mandatoryFieldMissing(String)
}

protocol EntryModelControllerProtocol {
    func createEntry(with title: String,body: String) throws
    func deleteEntry(entry: Entry) throws
    func countEntries() -> Int
    func listEntries() -> [Entry]
}

class EntryModelController: EntryModelControllerProtocol {
    static var shared: EntryModelControllerProtocol = EntryModelController()
    
    var entries = [Entry]()
    
    func createEntry(with title: String, body: String) throws {
        guard title.count <= 200 else {
            throw EntryModelControllerError.titleIsToLarge
        }
        
        guard !title.isEmpty else {
            throw EntryModelControllerError.mandatoryFieldMissing("Title")
        }
        
        guard !body.isEmpty else {
            throw EntryModelControllerError.mandatoryFieldMissing("Body")
        }
        
        let entry = Entry(title: title, body: body)
        entries.append(entry)
    }
    
    func deleteEntry(entry: Entry) throws  {
        guard let index = entries.firstIndex(of: entry) else {
            throw EntryModelControllerError.entryNotFound
        }
        entries.remove(at: index)
    }
    
    func countEntries() -> Int {
        entries.count
    }
    
    func listEntries() -> [Entry] {
        return entries
    }
}
