//
//  EpisodeListViewController.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 12/12/20.
//

import UIKit

protocol EpisodeListViewDelegate: AnyObject {
    func didLoadEpisodes()
    func errorOnLoadingEpisodes(error: Error)
    func showLoading(_ show: Bool)
}

final class EpisodeListViewController: UIViewController {
    
    public var delegate: EpisodeListViewModelDelegate?
    private var vm: EpisodeListViewModelDelegate
    
    lazy var episodeListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        let episodeCellNib = UINib(nibName: EpisodeTableViewCell.className, bundle: nil)
        tableView.register(episodeCellNib, forCellReuseIdentifier: EpisodeTableViewCell.className)
        return tableView
    }()
    
    init(viewModel: EpisodeListViewModelDelegate) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.loadEpisodes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setRandomQuoteButton()
        configureViews()
    }
    
    func configureViews() {
        view.backgroundColor = .white
        view.addSubview(episodeListTableView)
        NSLayoutConstraint.activate([
            episodeListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            episodeListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            episodeListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodeListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setRandomQuoteButton() {
        let randomQuoteButton = UIBarButtonItem.init(title: "Random Quote", style: .plain, target: self, action: #selector(openRandomQuote))
        self.navigationItem.setRightBarButton(randomQuoteButton, animated: true)
    }
    
    @objc func openRandomQuote() {
        self.delegate?.openRandomQuote()
    }
}

// MARK: - Table view data source
extension EpisodeListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.episodesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.className) as! EpisodeTableViewCell
        
        
        cell.presentData(episodeVM: vm.episode(for: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectEpisode(at: indexPath)
        
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
