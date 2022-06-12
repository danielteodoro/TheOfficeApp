//
//  RandomQuoteViewModel.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 22/12/20.
//

import Foundation

public class RandomQuoteViewModel: ObservableObject {
    
    var coordinatorDelegate: RandomQuoteCoordinatorDelegate?
    
    var service: WebServicing
    
    private var quote: Quote?
    
    var content: String? {
        willSet {
            objectWillChange.send()
        }
    }
    
    var characterFullName: String? {
        willSet {
            objectWillChange.send()
        }
    }
    
    var isLoading: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    var displayError: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    var error: Error?

    init(service: WebServicing = WebService()) {
        self.service = service
    }
    
    func loadRandomQuote() {
        isLoading = true
        service.fetch(from: .randomQuote, with: QuoteResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let quoteResponse):
                    self?.quote = quoteResponse.data
                    self?.setupContents()
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.displayError = true
                    self?.error = error
                    break
                }
            }
        }
    }
    
    func setupContents() {
        self.content = quote?.content ?? ""
        self.characterFullName = String("\(self.quote!.character.lastname), \(self.quote!.character.firstname)")
    }
    
    func close() {
        coordinatorDelegate?.closeRandomQuote()
    }
}
