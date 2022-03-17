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

    var willShowError = false
    
    func fetch<T: Decodable>(from endpoint: Endpoints, with class: T.Type, completion:  @escaping (Result<T, Error>) -> Void) {
        if willShowError {
            completion(.failure(ServiceError.generic))
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
                                                    Quote(_id: "321",
                                                          content: "I. DECLARE. BANKRUPTCY",
                                                          character: Character(_id: "321",
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

class EpisodeListViewModelTests: XCTestCase {
    
    private let serviceMock = WebServiceMock()
    private let delegate = EpisodeListViewModelDelegateMock()
    lazy var vm: EpisodeListViewModel = {
        let vm = EpisodeListViewModel(service: serviceMock)
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
