//
//  RandomQuoteViewController.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 22/12/20.
//

import UIKit

class RandomQuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteContentLabel: UILabel!
    @IBOutlet weak var quoteCharacter: UILabel!
    
    let vm: RandomQuoteViewModel
    
    public init(viewModel: RandomQuoteViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDelegate = self
    }
    
    func setQuoteContent() {
        self.quoteContentLabel.text = vm.content
        self.quoteCharacter.text = vm.characterFullName
    }
}

extension RandomQuoteViewController: RandomQuoteViewModelDelegate {
    func didLoadQuote() {
        self.setQuoteContent()
    }
    
    func errorOnLoadingQuote(error: Error) {
        displayError(error,cancelHandler: {_ in
            self.vm.close()
        }, retryHandler: {_ in
            self.vm.loadRandomQuote()
        })
    }
}
