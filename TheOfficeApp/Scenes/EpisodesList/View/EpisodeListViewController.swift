//
//  EpisodeListViewController.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 12/12/20.
//

import UIKit

protocol EpisodeListViewControllerDelegate {
    func didSelectEpisode(episodeVM: EpisodeViewModel)
}

class EpisodeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var delegate: EpisodeListViewControllerDelegate?
    
    let vm = EpisodeListViewModel()
    
    @IBOutlet weak var episodeListTableView: UITableView! {
        didSet {
            episodeListTableView?.dataSource = self
            episodeListTableView?.delegate = self
            
            let episodeCellNib = UINib(nibName: String(describing: EpisodeTableViewCell.self), bundle: nil)
            episodeListTableView.register(episodeCellNib, forCellReuseIdentifier: String(describing: EpisodeTableViewCell.self))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.episodesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EpisodeTableViewCell.self)) as! EpisodeTableViewCell
        
        
        cell.presentData(episodeVM: vm.episodesVM[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selecionado")
        self.delegate?.didSelectEpisode(episodeVM: vm.episodesVM[indexPath.row])
    }
    
}

extension EpisodeListViewController: EpisodeListViewModelDelegate {
    func didLoadEpisodes() {
        self.episodeListTableView.reloadData()
    }
    
    func errorOnLoadingEpisodes(error: Error) {
        print(error)
    }
}
