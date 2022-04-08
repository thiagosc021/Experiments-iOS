//
//  TaskController.swift
//  Task
//
//  Created by Thiago Costa on 4/5/22.
//

import Foundation

protocol TaskControllerProtocol {
    func createTaskWith(name: String, notes: String?, dueDate: Date?)
    func update(task: Task, name: String, notes: String?, dueDate: Date?)
    func toggleIsComplete(task: Task)
    func delete(task: Task)
    func countTasks() -> Int
    func fetchTasks() -> [Task]
}

class TaskController: TaskControllerProtocol {
    private var tasks = [Task]()
    private var storage: FileSystemStorageProtocol
    private static let fileName = "Tasks.json"
    
    static var shared: TaskControllerProtocol = TaskController(storage: FileSystemStorage(fileName: fileName))
    
    init(storage: FileSystemStorageProtocol) {
        self.storage = storage
    }
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let task = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(task)
        saveToDisk(tasks: tasks)
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        if let i = tasks.firstIndex(of: task) {
            tasks[i].name = name
            tasks[i].notes = notes
            tasks[i].dueDate = dueDate
        }
        saveToDisk(tasks: tasks)
    }
    
    func toggleIsComplete(task: Task) {
        tasks.first(where: { $0 == task })?.isComplete.toggle()
        saveToDisk(tasks: tasks)
    }
    
    func delete(task: Task) {    
        tasks.removeAll(where: { $0 == task })
        saveToDisk(tasks: tasks)
    }
    
    func countTasks() -> Int {
        return tasks.count
    }
    
    func fetchTasks() -> [Task] {
        if tasks.isEmpty {
            loadFromDisk()
        }
        
        return tasks
    }
}

private extension TaskController {
    func loadFromDisk() {
        do {
            tasks = try storage.loadFromPersistentStorage([Task].self)
        } catch let error {
            print(error)
        }
    }
    func saveToDisk(tasks: [Task]) {
        do {
            try storage.saveToPersistentStorage(content: tasks)
        } catch let error {
            //TODO: show an alert message with the error localized message
            print(error)
        }
    }
}
