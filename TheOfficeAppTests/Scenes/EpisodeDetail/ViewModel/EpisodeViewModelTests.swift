//
//  EpisodeViewModelTests.swift
//  TheOfficeAppTests
//
//  Created by Daniel Teodoro on 25/11/20.
//

import XCTest
@testable import TheOfficeApp

class EpisodeViewModelTests: XCTestCase {

    var vm: EpisodeViewModel = EpisodeViewModel(episode: Episode(_id: "123", title: "Pilot", description: "Michael makes a joke.", airDate: "2005-03-29T06:00:00.000Z", director: CrewMember(_id: "321", name: "Greg Daniels", role: "Director"), writer: CrewMember(_id: "321", name: "Greg Daniels", role: "Director")))
    
    func testName() {
        XCTAssertEqual(vm.title, "Pilot")
    }
    
    func testDescription() {
        XCTAssertEqual(vm.description, "Michael makes a joke.")
    }
    
    func testAirDate() {
        XCTAssertEqual(vm.airDate, "mar. 29, 2005")
    }
    
    func testDirectorName() {
        XCTAssertEqual(vm.directorName, "Greg Daniels")
    }
    
    func testDirectorNameLabelText() {
        XCTAssertEqual(vm.directorNameLabelText, "Director: Greg Daniels")
    }
    
    func testWriterName() {
        XCTAssertEqual(vm.writerName, "Greg Daniels")
    }
    
    func testDirector() {
        XCTAssertEqual(vm.getDirector(), CrewMember(_id: "321", name: "Greg Daniels", role: "Director"))
    }
    
    func testWriter() {
        XCTAssertEqual(vm.getWriter(), CrewMember(_id: "321", name: "Greg Daniels", role: "Director"))
    }
}
