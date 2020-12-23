//
//  RandomQuoteViewModel.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 22/12/20.
//

import Foundation

protocol RandomQuoteViewModelDelegate {
    func didLoadQuote()
    func errorOnLoadingQuote(error: Error)
}

class RandomQuoteViewModel {
    
    var delegate: RandomQuoteViewModelDelegate?
    
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
                self?.delegate?.didLoadQuote()
                print(quote.content)
            case .failure(let error):
                self?.delegate?.errorOnLoadingQuote(error: error)
                break
            }
        }
    }
}
