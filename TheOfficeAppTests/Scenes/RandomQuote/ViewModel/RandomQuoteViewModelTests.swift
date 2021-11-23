//
//  RandomQuoteViewModelTests.swift
//  TheOfficeAppTests
//
//  Created by Daniel Teodoro on 13/06/21.
//

import XCTest
@testable import TheOfficeApp

class RandomQuoteViewModelTests: XCTestCase {

    private let serviceMock = WebServiceMock()
    private let delegate = RandomQuoteViewDelegateMock()
    private let coordinatorDelegate = RandomQuoteCoordinatorDelegateMock()
    lazy var vm: RandomQuoteViewModel = {
        let vm = RandomQuoteViewModel(service: serviceMock)
        vm.viewDelegate = delegate as RandomQuoteViewDelegate
        vm.coordinatorDelegate = coordinatorDelegate
        return vm
    }()
    
    func testErrorResponse() {
        serviceMock.willShowError = true
        vm.loadRandomQuote()
        
        XCTAssertTrue(delegate.didCallErrorOnLoadingQuote)
    }
    
    func testSuccess() {
        vm.loadRandomQuote()
        
        XCTAssertTrue(delegate.didCallDidLoadQuote)
    }
    
    func testsContent() {
        XCTAssertEqual(vm.content, "")

        vm.loadRandomQuote()
        
        XCTAssertEqual(vm.content, "I. DECLARE. BANKRUPTCY")
    }
    
    func testsCharacterFullName() {
        vm.loadRandomQuote()
        
        XCTAssertEqual(vm.characterFullName, "Scott, Michael")
    }
    
    func testClose() {
        vm.close()
        XCTAssertTrue(coordinatorDelegate.didCloseRandomQuote)
    }
}

class RandomQuoteCoordinatorDelegateMock: RandomQuoteCoordinatorDelegate {
    
    var didCloseRandomQuote = false
    
    func closeRandomQuote() {
        didCloseRandomQuote = true
    }
}

class RandomQuoteViewDelegateMock: RandomQuoteViewDelegate {
    
    var didCallDidLoadQuote = false
    var didCallErrorOnLoadingQuote = false
    var didCallShowLoading = false
    
    func didLoadQuote() {
        didCallDidLoadQuote = true
    }
    
    func errorOnLoadingQuote(error: Error) {
        didCallErrorOnLoadingQuote = true
    }
    
    func showLoading(_ show: Bool) {
        didCallShowLoading = show
    }
}
