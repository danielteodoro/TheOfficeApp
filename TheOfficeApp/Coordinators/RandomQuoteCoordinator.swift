//
//  RandomQuoteCoordinator.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 22/12/20.
//

import UIKit

class RandomQuoteCoordinator: Coordinator {
    
    private let presenter: Router
    
    var view: RandomQuoteViewController?
    var viewModel: RandomQuoteViewModel?
    
    init(presenter: Router){
        self.presenter = presenter
    }
    
    func start() {
        let viewModel = RandomQuoteViewModel()
        let randomQuoteViewController = RandomQuoteViewController(viewModel: viewModel)
        presenter.present(randomQuoteViewController, animated: true)
        
        viewModel.coordinatorDelegate = self
        
        self.viewModel = viewModel
        self.view = randomQuoteViewController
    }
    
    func stop() {
        self.view = nil
        self.viewModel = nil
    }
}

extension RandomQuoteCoordinator: RandomQuoteCoordinatorDelegate {
    func closeRandomQuote() {
        self.presenter.dismissModule(animated: true, completion: nil)
        self.stop()
    }
}
