//
//  EntryModelControllerTests.swift
//  JournalTests
//
//  Created by Thiago Costa on 3/31/22.
//

import XCTest

class EntryModelControllerTests: XCTestCase {

//    func testIfNewEntryWithALargeTitleThenThrows() {
//        
//        let entryModelController = Entr
//        
//        let titleWithMoreThan200Characters = "ubq uiiuq biuqbiu bqiub iqub iuqb iuqiu bqiu biu iuqbqiub qiub iqu iqubiuq bqiu bqiu bqiub qiub qiub qiub qiu qbiub qiub qiub qiub qiub qiu biubq iub qiub qiu bqiu iuqb iuqb q ubq uiiuq biuqbiu bqiub iqub iuqb iuqiu bqiu biu iuqbqiub qiub iqu iqubiuq bqiu bqiu bqiub qiub qiub qiub qiu qbiub qiub qiub qiub qiub qiu biubq iub qiub qiu bqiu iuqb iuqb ubq uiiuq biuqbiu bqiub iqub iuqb iuqiu bqiu biu iuqbqiub qiub iqu iqubiuq bqiu bqiu bqiub qiub qiub qiub qiu qbiub qiub qiub qiub qiub qiu biubq iub qiub qiu bqiu iuqb iuqb ubq uiiuq biuqbiu bqiub iqub iuqb iuqiu bqiu biu iuqbqiub qiub iqu iqubiuq bqiu bqiu bqiub qiub qiub qiub qiu qbiub qiub qiub qiub qiub qiu biubq iub qiub qiu bqiu iuqb iuqb ubq uiiuq biuqbiu bqiub iqub iuqb iuqiu bqiu biu iuqbqiub qiub iqu iqubiuq bqiu bqiu bqiub qiub qiub qiub qiu qbiub qiub qiub qiub qiub qiu biubq iub qiub qiu bqiu iuqb iuqb"
//        
//        let body = "iuwenfiu iu iuwehfuwhe iwefbiuwe huihwejhr ilwenr weruiewgr iwe  ;weih iuwh iuweh iwh w. wenrtiwebfij w WE hiuwe iweb iwef kq ejdn iqe fwejn iweerbngij wiruh giuerh iuewhf iuwe iwuehfiuwefjwngioejtgoirwmfoirejgiowrjf oweiugh owir gjhoirwje reworgrwfnwrijvnwe iofn gwruheir hiwur oiqewjf owiejf weoh woei howeirrh owerh oweirjr oeiwhwoeiweoihroiwehroewhr owie"
//        
//        XCTAssertThrowsError(try EntryModelController.shared.createEntry(with: titleWithMoreThan200Characters, body: body))
//                
//    }
//    
//    func testIfNewEntryWithEmptyTitleThenThrows() {
//        EntryModelController.shared = EntryModelController(storage: FileSystemStorageMock())
//        
//        let body = "iuwenfiu iu iuwehfuwhe iwefbiuwe huihwejhr ilwenr weruiewgr iwe  ;weih iuwh iuweh iwh w. wenrtiwebfij w WE hiuwe iweb iwef kq ejdn iqe fwejn iweerbngij wiruh giuerh iuewhf iuwe iwuehfiuwefjwngioejtgoirwmfoirejgiowrjf oweiugh owir gjhoirwje reworgrwfnwrijvnwe iofn gwruheir hiwur oiqewjf owiejf weoh woei howeirrh owerh oweirjr oeiwhwoeiweoihroiwehroewhr owie"
//        
//        XCTAssertThrowsError(try EntryModelController.shared.createEntry(with: "", body: body))
//        
//    }
//    
//    func testIfNewEntryWithEmptyBodyThenThrows() {
//        EntryModelController.shared = EntryModelController(storage: FileSystemStorageMock())
//        
//        let title = "Title"
//        let body = ""
//        
//        XCTAssertThrowsError(try EntryModelController.shared.createEntry(with: title, body: body))
//    }
//    
//    func testIfNewValidEntryThenIncreaseCount() {
//        EntryModelController.shared = EntryModelController(storage: FileSystemStorageMock())
//        
//        let initialCount = EntryModelController.shared.countEntries()
//        
//        XCTAssertNoThrow(try EntryModelController.shared.createEntry(with: "New Entry", body: "New Entry"))
//        
//        let finalCount = EntryModelController.shared.countEntries()
//        
//        XCTAssertTrue(finalCount == (initialCount + 1))
//    }
//    
//    func testIfRemoveInvalidEntryThenThrows() {
//        EntryModelController.shared = EntryModelController(storage: FileSystemStorageMock())
//        
//        let entry = Entry(title: "not a valid entry", body: "not a valid entry")
//        
//        XCTAssertThrowsError(try EntryModelController.shared.deleteEntry(entry: entry))
//    }

}
