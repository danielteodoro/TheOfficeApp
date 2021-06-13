//
//  Router.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 08/12/20.
//

import UIKit

protocol Router {
    
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }
    func present(_ module: Showable, animated: Bool)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func push(_ module: Showable, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
}
