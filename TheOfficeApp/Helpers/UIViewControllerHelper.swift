//
//  UIViewControllerHelper.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 05/06/21.
//

import UIKit

extension UIViewController {

    func displayError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default)
        { action -> Void in
            alert.dismiss(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
    }
}
