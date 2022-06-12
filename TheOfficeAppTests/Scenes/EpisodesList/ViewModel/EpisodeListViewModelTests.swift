//
//  EpisodeListViewModelTests.swift
//  TheOfficeAppTests
//
//  Created by Daniel Teodoro on 24/11/20.
//

import XCTest
@testable import TheOfficeApp

class WebServiceMock: WebServicing {
    
    var willShowError = false
    
    func fetch<T>(from endpoint: TheOfficeApp.Endpoints, with class: T.Type, completion: @escaping (Result<T, TheOfficeApp.ServiceError>) -> Void) where T : Decodable {
        if willShowError {
            completion(.failure(TheOfficeApp.ServiceError.emptyData))
        } else {
            switch endpoint {
            case .episodes:
                completion(.success(EpisodeResponse(data: [
                    Episode(_id: "123",
                            title: "Pilot",
                            description: "Michael makes a joke.",
                            airDate: "test date",
                            director: CrewMember(_id: "321",
                                                 name: "Greg Daniels",
                                                 role: "Director"),
                            writer: CrewMember(_id: "321",
                                               name: "Greg Daniels",
                                               role: "Director"))
                ]) as! T))
            case .randomQuote:
                completion(.success(QuoteResponse(data:
                                                    Quote(id: "321",
                                                          content: "I. DECLARE. BANKRUPTCY",
                                                          character: Character(id: "321",
                                                                               firstname: "Michael",
                                                                               lastname: "Scott"))) as! T))
            }
        }
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

class CoordinatorMock: EpisodeListCoordinatorDelegate {
    var actionToBePerformed: EpisodeListCoordinatorAction?
    
    func perform(_ action: TheOfficeApp.EpisodeListCoordinatorAction) {
        actionToBePerformed = action
    }
}

class EpisodeListViewModelTests: XCTestCase {
    
    private let serviceMock = WebServiceMock()
    private let delegate = EpisodeListViewModelDelegateMock()
    private let coordinator = CoordinatorMock()
    lazy var vm: EpisodeListViewModel = {
        let vm = EpisodeListViewModel(coordinatorDelegate: coordinator, service: serviceMock)
        vm.viewDelegate = delegate
        return vm
    }()
    
    func testErrorResponse() {
        serviceMock.willShowError = true
        vm.loadEpisodes()
        
        XCTAssertEqual(delegate.errorOnLoadingEpisodesCount, 1)
    }
    
    func testSuccess() {
        vm.loadEpisodes()
        
        XCTAssertEqual(delegate.didLoadEpisodesCount, 1)
    }
}
