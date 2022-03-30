//
//  EntryModelController.swift
//  Journal
//
//  Created by Thiago Costa on 3/29/22.
//

import Foundation
import UIKit

enum EntryModelControllerError: Error {
    case entryNotFound
    case titleIsToLarge
    case mandatoryFieldMissing(String)
}

protocol EntryModelControllerProtocol {
    func createEntry(with title: String,body: String) throws
    func updateEntry(entry: Entry) throws
    func deleteEntry(entry: Entry) throws
    func countEntries() -> Int
    func listEntries() -> [Entry]
}

class EntryModelController: EntryModelControllerProtocol {
    static var shared: EntryModelControllerProtocol = EntryModelController(storage: FileSystemStorage())
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let storage: FileSystemStorageProtocol
    
    init(storage: FileSystemStorageProtocol) {
        self.storage = storage
    }
    
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
        
        try storage.saveToPersistentStorage(content: entries)
    }
    
    func deleteEntry(entry: Entry) throws  {
        guard let index = entries.firstIndex(of: entry) else {
            throw EntryModelControllerError.entryNotFound
        }
        entries.remove(at: index)
        
        try storage.saveToPersistentStorage(content: entries)
    }
    
    func countEntries() -> Int {
        entries.count
    }
    
    func listEntries() -> [Entry] {
        if entries.count == 0 {
            do {
                try entries = storage.loadFromPersistentStorage([Entry].self)
            } catch let error {
                print(error)
            }
        }
        return entries
    }
    
    func updateEntry(entry: Entry) throws {
        try deleteEntry(entry: entry)
        try createEntry(with: entry.title, body: entry.body)
    }
}

