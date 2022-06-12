//
//  RandomQuoteCoordinator.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 22/12/20.
//

import UIKit
import SwiftUI

protocol RandomQuoteCoordinatorDelegate {
    func closeRandomQuote()
}

class RandomQuoteCoordinator: Coordinator {
    
    private let presenter: Router
    
    var view: RandomQuoteSwiftUIView?
    var viewModel: RandomQuoteViewModel?
    
    init(presenter: Router){
        self.presenter = presenter
    }
    
    func start() {
        let viewModel = RandomQuoteViewModel()
        let randomQuoteView: RandomQuoteSwiftUIView = RandomQuoteSwiftUIView(viewModel: viewModel)
        
        presenter.present(UIHostingController(rootView: randomQuoteView), animated: true)
        
        viewModel.coordinatorDelegate = self
        
        self.viewModel = viewModel
        self.view = randomQuoteView
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
