//
//  CrewMemberInfoViewModelTests.swift
//  TheOfficeAppTests
//
//  Created by Daniel Teodoro on 12/06/21.
//

import XCTest
@testable import TheOfficeApp

class CrewMemberInfoViewModelTests: XCTestCase {
    
    lazy var vm: CrewMemberInfoViewModel = {
        let vm = CrewMemberInfoViewModel(crewMember: CrewMember(_id: "321", name: "Greg Daniels", role: "Director"), title: "Director")
        return vm
    }()
    
    func testName() {
        XCTAssertEqual(vm.name, "Greg Daniels")
    }
    
    func testRoles() {
        XCTAssertEqual(vm.roles, "Director")
    }
}
