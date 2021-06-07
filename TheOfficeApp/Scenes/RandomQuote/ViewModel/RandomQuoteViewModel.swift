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

protocol RandomQuoteViewModelDelegate {
    func didLoadQuote()
    func errorOnLoadingQuote(error: Error)
}

class RandomQuoteViewModel {
    
    var coordinatorDelegate: RandomQuoteCoordinatorDelegate?
    var viewDelegate: RandomQuoteViewModelDelegate?
    
    var service: WebServicing
    
    private var quote: Quote?
    
    var content: String {
        return  quote?.content ?? ""
    }
    
    var characterFullName: String {
        return  String("\(self.quote!.character.firstname) \(self.quote!.character.lastname)")
    }
    
    init(service: WebServicing = WebService()) {
        self.service = service
        loadRandomQuote()
    }
    
    func loadRandomQuote() {
        service.fetchRandomQuote() { [weak self] result in
            switch result {
            case .success(let quote):
                self?.quote = quote
                self?.viewDelegate?.didLoadQuote()
                print(quote.content)
            case .failure(let error):
                self?.viewDelegate?.errorOnLoadingQuote(error: error)
                break
            }
        }
    }
    
    func close() {
        coordinatorDelegate?.closeRandomQuote()
    }
}
