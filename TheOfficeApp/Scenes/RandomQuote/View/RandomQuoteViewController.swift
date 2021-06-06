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
    
    let vm: RandomQuoteViewModel = RandomQuoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
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
        print(error.localizedDescription)
    }
}
