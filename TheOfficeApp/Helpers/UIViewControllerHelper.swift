//
//  UIViewControllerHelper.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 05/06/21.
//

import UIKit

extension UIViewController {

    func displayError(_ error: Error, cancelHandler: ((UIAlertAction) -> Void)? = nil, retryHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        if let cancelHandler = cancelHandler {
            alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: cancelHandler))
        } 
        
        if let retryHandler = retryHandler {
            alert.addAction(UIAlertAction(title: "retry", style: .default, handler: retryHandler))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
