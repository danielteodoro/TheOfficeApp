//
//  EpisodesListTableViewController.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import UIKit

class EpisodesListTableViewController: UITableViewController {
    
    let vm = EpisodeListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.episodesVM.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EpisodeTableViewCell.self), for: indexPath) as! EpisodeTableViewCell

        cell.presentData(episodeVM: vm.episodesVM[indexPath.row])

        return cell
    }

}

extension EpisodesListTableViewController: EpisodeListViewModelDelegate {
    func didLoadEpisodes() {
        tableView.reloadData()
    }
    
    func errorOnLoadingEpisodes(error: Error) {
        print(error)
    }
}
