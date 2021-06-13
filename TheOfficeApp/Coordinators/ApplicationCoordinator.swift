//
//  ApplicationCoordinator.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 12/12/20.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let episodeListCoordinator: EpisodeListCoordinator
    let officeRouter: OfficeRouter
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        officeRouter = OfficeRouter(navigationController: rootViewController)
        episodeListCoordinator = EpisodeListCoordinator(presenter: officeRouter)
    }
    
    func start() {
        window.rootViewController = rootViewController
        episodeListCoordinator.start()
        window.makeKeyAndVisible()
    }
    
    func stop() {
        
    }
}
