//
//  RandomQuoteViewModelTests.swift
//  TheOfficeAppTests
//
//  Created by Daniel Teodoro on 13/06/21.
//

import XCTest
@testable import TheOfficeApp

class RandomQuoteViewModelTests: XCTestCase {
    private let serviceMock = RandomQuoteServiceMock()
    private let coordinatorDelegate = RandomQuoteCoordinatorDelegateMock()
    lazy var vm: RandomQuoteViewModel = {
        let vm = RandomQuoteViewModel(service: serviceMock)
        vm.coordinatorDelegate = coordinatorDelegate
        return vm
    }()
    let queue = DispatchQueue(label: "wait response")
    
    func testErrorResponse() {
        vm.loadRandomQuote()
        
        queue.asyncAfter(deadline: .now() + .milliseconds(500)) { [self] in
            XCTAssertTrue(vm.displayError)
        }
    }
    
    func testSuccess() {
        vm.loadRandomQuote()
        
        queue.asyncAfter(deadline: .now() + .milliseconds(500)) { [self] in
            XCTAssertNotNil(vm.content)
            XCTAssertNotNil(vm.characterFullName)
        }
    }
    
    func testsContent() {
        XCTAssertNil(vm.content)

        vm.loadRandomQuote()
        queue.asyncAfter(deadline: .now() + .milliseconds(500)) { [self] in
            XCTAssertEqual(vm.content, "I. DECLARE. BANKRUPTCY")
        }
    }
    
    func testsCharacterFullName() {
        vm.loadRandomQuote()
        
        queue.asyncAfter(deadline: .now() + .milliseconds(500)) { [self] in
            XCTAssertEqual(vm.characterFullName, "Scott, Michael")
        }
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

class RandomQuoteServiceMock: WebServicing {
    var willReturnError = true
    var completeExpectation: XCTestExpectation?
    
    func fetch<T>(from endpoint: TheOfficeApp.Endpoints, with class: T.Type, completion: @escaping (Result<T, TheOfficeApp.ServiceError>) -> Void) where T : Decodable {
        
        if willReturnError{
            completion(.failure(.invalidURL))
            completeExpectation?.fulfill()
        }
        
        completion(
            .success(QuoteResponse(data: (Quote(id: "321",
                                                content: "I. DECLARE. BANKRUPTCY",
                                                character: Character(id: "321",
                                                                     firstname: "Michael",
                                                                     lastname: "Scott")
                                               )
            )) as! T)
        )
        
        completeExpectation?.fulfill()
    }
}
