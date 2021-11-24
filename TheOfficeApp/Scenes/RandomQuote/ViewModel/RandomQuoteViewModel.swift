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

public class RandomQuoteViewModel: ObservableObject {
    
    var coordinatorDelegate: RandomQuoteCoordinatorDelegate?
    var viewDelegate: RandomQuoteViewDelegate?
    
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

    init(service: WebServicing = WebService()) {
        self.service = service
    }
    
    func loadRandomQuote() {
        viewDelegate?.showLoading(true)
        service.fetchRandomQuote() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let quote):
                    self?.quote = quote
                    //                self?.viewDelegate?.didLoadQuote()
                    self?.setupContents()
                    self?.viewDelegate?.showLoading(false)
                case .failure(let error):
                    self?.viewDelegate?.errorOnLoadingQuote(error: error)
                    self?.viewDelegate?.showLoading(false)
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
