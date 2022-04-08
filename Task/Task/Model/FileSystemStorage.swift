//
//  FileSystemStorage.swift
//  Task
//
//  Created by Thiago Costa on 4/5/22.
//

import Foundation

protocol FileSystemStorageProtocol {
    func saveToPersistentStorage<T>(content: T) throws where T:Encodable
    func loadFromPersistentStorage<T>(_ type: T.Type) throws -> T where T:Decodable
}

class FileSystemStorage: FileSystemStorageProtocol {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func saveToPersistentStorage<T>(content: T) throws where T : Encodable {
        let jsonData = try encoder.encode(content)
        let url = fileURL()
        try jsonData.write(to: url)
    }
    
    func loadFromPersistentStorage<T>(_ type: T.Type) throws -> T where T : Decodable {
        let url = fileURL()
        let jsonData = try Data(contentsOf: url)
        let entries = try decoder.decode(type, from: jsonData)
        return entries
    }
}

private extension FileSystemStorage {
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
}

#if DEBUG
class FileSystemStorageMock: FileSystemStorageProtocol{
    func saveToPersistentStorage<T>(content: T) throws where T : Encodable {
    }
    
    func loadFromPersistentStorage<T>(_ type: T.Type) throws -> T where T : Decodable {
        return ["aa"] as! T
    }
}
#endif
