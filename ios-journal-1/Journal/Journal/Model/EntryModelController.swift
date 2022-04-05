//
//  EntryModelController.swift
//  Journal
//
//  Created by Thiago Costa on 3/29/22.
//

import Foundation
import UIKit

enum ModelControllerError: Error {
    case notFound
    case titleIsToLarge
    case mandatoryFieldMissing(String)
}

protocol EntryModelControllerProtocol {
    func createEntry(with title: String,body: String, journal: Journal) throws
    func updateEntry(entry: Entry, journal: Journal) throws
    func deleteEntry(entry: Entry, journal: Journal) throws
}

class EntryModelController: EntryModelControllerProtocol {
    
    private let journalModelController: JournalModelControllerProtocol
    
    init(journalModelController: JournalModelControllerProtocol) {
        self.journalModelController = journalModelController
    }
    
    func createEntry(with title: String, body: String, journal: Journal) throws {
        guard title.count <= 200 else {
            throw ModelControllerError.titleIsToLarge
        }
        
        guard !title.isEmpty else {
            throw ModelControllerError.mandatoryFieldMissing("Title")
        }
        
        guard !body.isEmpty else {
            throw ModelControllerError.mandatoryFieldMissing("Body")
        }
        
        let entry = Entry(title: title, body: body)
        
        try journalModelController.addEntriesTo(journal: journal, entry: entry)
    }
    
    func deleteEntry(entry: Entry, journal: Journal) throws  {
        try journalModelController.removeEntryFrom(journal: journal, entry: entry)
    }
    
    func updateEntry(entry: Entry, journal: Journal) throws {
        try journalModelController.removeEntryFrom(journal: journal, entry: entry)
        try createEntry(with: entry.title, body: entry.body, journal: journal)
    }
}

