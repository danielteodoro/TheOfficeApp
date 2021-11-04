//
//  RandomQuoteViewModel.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 22/12/20.
//

import Foundation

protocol RandomQuoteCoordinatorDelegate {
    func closeRandomQuote()
}

protocol RandomQuoteViewDelegate {
    func didLoadQuote()
    func errorOnLoadingQuote(error: Error)
    func showLoading(_ show: Bool)
}

class RandomQuoteViewModel {
    
    var coordinatorDelegate: RandomQuoteCoordinatorDelegate?
    var viewDelegate: RandomQuoteViewDelegate?
    
    var service: WebServicing
    
    private var quote: Quote?
    
    var content: String {
        return  quote?.content ?? ""
    }
    
    var characterFullName: String {
        return  String("\(self.quote!.character.lastname), \(self.quote!.character.firstname)")
    }
    
    init(service: WebServicing = WebService()) {
        self.service = service
    }
    
    func loadRandomQuote() {
        viewDelegate?.showLoading(true)
        service.fetch(from: Endpoints.randomQuote, with: QuoteResponse.self) { [weak self] result in
            switch result {
            case .success(let quote):
                self?.quote = quote.data
                self?.viewDelegate?.didLoadQuote()
                self?.viewDelegate?.showLoading(false)
            case .failure(let error):
                self?.viewDelegate?.errorOnLoadingQuote(error: error)
                self?.viewDelegate?.showLoading(false)
                break
            }
        }
    }
    
    func close() {
        coordinatorDelegate?.closeRandomQuote()
    }
}
