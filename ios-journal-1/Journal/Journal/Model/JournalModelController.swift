//
//  JournalModelController.swift
//  Journal
//
//  Created by Thiago Costa on 3/31/22.
//

import Foundation

protocol JournalModelControllerProtocol {
    func createJournalWith(title: String) throws
    func deleteJournal(journal: Journal) throws
    func addEntriesTo(journal: Journal, entry: Entry) throws
    func removeEntryFrom(journal: Journal, entry: Entry) throws
    func journalCount() -> Int
    func getJournal(by index: Int) -> Journal
    func loadJournalList()
}


class JournalModelController: JournalModelControllerProtocol {
    static var shared: JournalModelControllerProtocol = JournalModelController(storage: FileSystemStorage())
    var journalList = [Journal]()
    private let storage: FileSystemStorageProtocol
    
    init(storage: FileSystemStorageProtocol) {
        self.storage = storage
    }
    
    func loadJournalList() {
        do {
            journalList = try storage.loadFromPersistentStorage([Journal].self)
        } catch let error {
            print(error)
        }
    }
    
    func journalCount() -> Int{
        return journalList.count
    }
    
    func getJournal(by index: Int) -> Journal {
        return journalList[index]
    }
    
    func createJournalWith(title: String) throws {
        let newJournal = Journal(title: title)
        journalList.append(newJournal)
        try storage.saveToPersistentStorage(content: journalList)
    }
    
    func deleteJournal(journal: Journal) throws {
        guard let index = journalList.firstIndex(of: journal) else {
            throw ModelControllerError.notFound
        }
        journalList.remove(at: index)
        
        try storage.saveToPersistentStorage(content: journalList)
    }
    
    func addEntriesTo(journal: Journal, entry: Entry) throws {
        guard let index = journalList.firstIndex(of: journal) else {
            throw ModelControllerError.notFound
        }
        journalList[index].entries.append(entry)
        
        try storage.saveToPersistentStorage(content: journalList)
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) throws {
        guard let journalIndex = journalList.firstIndex(of: journal),
              let entryIndex = journalList[journalIndex].entries.firstIndex(of: entry) else {
            throw ModelControllerError.notFound
        }
        journalList[journalIndex].entries.remove(at: entryIndex)
        
        try storage.saveToPersistentStorage(content: journalList)
    }
    
    
    
}
