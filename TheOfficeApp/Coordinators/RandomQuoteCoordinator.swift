//
//  RandomQuoteCoordinator.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 22/12/20.
//

import UIKit

class RandomQuoteCoordinator: Coordinator {
    
    private let presenter: Router
    private var randomQuoteViewController: RandomQuoteViewController?
    
    init(presenter: Router){
        self.presenter = presenter
    }
    
    func start() {
        let randomQuoteViewController = RandomQuoteViewController()
        presenter.present(randomQuoteViewController, animated: true)
        
        self.randomQuoteViewController = randomQuoteViewController
    }
}
