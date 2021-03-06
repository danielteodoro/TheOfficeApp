//
//  EpisodeListViewModelTests.swift
//  TheOfficeAppTests
//
//  Created by Daniel Teodoro on 24/11/20.
//

import XCTest
@testable import TheOfficeApp

enum ServiceError: Error {
    case generic
}

class WebServiceMock: WebServicing {
    
    var result: Result<[Episode], Error> = .failure(ServiceError.generic)
    var quoteResult: Result<Quote, Error> = .failure(ServiceError.generic)
    
    func fetchEpisodes(completion: @escaping (Result<[Episode], Error>) -> Void) {
        completion(result)
    }
    
    func fetchRandomQuote(completion: @escaping (Result<Quote, Error>) -> Void) {
        completion(quoteResult)
    }
}

class EpisodeListViewModelDelegateMock: EpisodeListViewDelegate{
    
    var errorOnLoadingEpisodesCount = 0
    var didLoadEpisodesCount = 0
    var didCallShowLoading = false
    
    func didLoadEpisodes() {
        didLoadEpisodesCount += 1
    }
    
    func errorOnLoadingEpisodes(error: Error) {
        errorOnLoadingEpisodesCount += 1
    }

    func showLoading(_ show: Bool) {
        didCallShowLoading = show
    }
}

class EpisodeListViewModelTests: XCTestCase {
    
    private let serviceMock = WebServiceMock()
    private let delegate = EpisodeListViewModelDelegateMock()
    lazy var vm: EpisodeListViewModel = {
        let vm = EpisodeListViewModel(service: serviceMock)
        vm.viewDelegate = delegate
        return vm
    }()
    
    func testErrorResponse() {
        vm.loadEpisodes()
        
        XCTAssertEqual(delegate.errorOnLoadingEpisodesCount, 1)
    }
    
    func testSuccess() {
        serviceMock.result = .success([Episode(_id: "123", title: "Pilot", description: "Michael makes a joke.", airDate: "test date", director: CrewMember(_id: "321", name: "Greg Daniels", role: "Director"), writer: CrewMember(_id: "321", name: "Greg Daniels", role: "Director"))])
        vm.loadEpisodes()
        
        XCTAssertEqual(delegate.didLoadEpisodesCount, 1)
    }
}
