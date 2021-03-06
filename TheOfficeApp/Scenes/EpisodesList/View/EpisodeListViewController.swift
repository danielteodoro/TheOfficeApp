//
//  EpisodeListViewController.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 12/12/20.
//

import UIKit

protocol EpisodeListViewControllerDelegate {
    func didSelectEpisode(episodeVM: EpisodeViewModel)
    func openRandomQuote()
}

class EpisodeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var delegate: EpisodeListViewControllerDelegate?
    
    let vm = EpisodeListViewModel()
    
    @IBOutlet weak var episodeListTableView: UITableView! {
        didSet {
            episodeListTableView?.dataSource = self
            episodeListTableView?.delegate = self
            
            let episodeCellNib = UINib(nibName: EpisodeTableViewCell.className, bundle: nil)
            episodeListTableView.register(episodeCellNib, forCellReuseIdentifier: EpisodeTableViewCell.className)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDelegate = self
        vm.loadEpisodes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setRandomQuoteButton()
    }
    
    func setRandomQuoteButton() {
        let randomQuoteButton = UIBarButtonItem.init(title: "Random Quote", style: .plain, target: self, action: #selector(openRandomQuote))
        self.navigationItem.setRightBarButton(randomQuoteButton, animated: true)
    }
    
    @objc func openRandomQuote() {
        self.delegate?.openRandomQuote()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.episodesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.className) as! EpisodeTableViewCell
        
        
        cell.presentData(episodeVM: vm.episodesVM[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectEpisode(episodeVM: vm.episodesVM[indexPath.row])
        
        self.episodeListTableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension EpisodeListViewController: EpisodeListViewDelegate {
    
    func didLoadEpisodes() {
        self.episodeListTableView.reloadData()
    }
    
    func errorOnLoadingEpisodes(error: Error) {
        displayError(error, retryHandler: {_ in
            self.vm.loadEpisodes()
        })
    }
}
