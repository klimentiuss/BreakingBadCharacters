//
//  MainListTableVC.swift
//  BreakingBadCharacters
//
//  Created by Daniil Klimenko on 24.06.2022.
//

import UIKit

class MainListTableVC: UITableViewController {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Private properties
    private var character: [Character]?
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredChracter: [Character] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true

        configureRefreshControl()
        
        setupNavigationBar()
        setupSearchController()
        fetchData(from: breakingURLS.characterURL.rawValue)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredChracter.count : character?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let charactar = isFiltering ? filteredChracter[indexPath.row] : character?[indexPath.row]
        cell.configure(with: charactar)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = isFiltering ? filteredChracter[indexPath.row] : character?[indexPath.row]
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.character = character
        
    }
    
    
    // MARK: - Private methods
    //Setup Search bar
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    // Setup navigation bar
    private func setupNavigationBar() {
        
        title = "BreakingBad"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Navigation bar appearance
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .black
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchCharacter(from: url) { charactar in
            self.character = charactar
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    //RefreshControllManaging
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl),for: .valueChanged)
        tableView.refreshControl?.tintColor = .white
    }
    @objc func handleRefreshControl() {
        fetchData(from: breakingURLS.characterURL.rawValue)
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
}


extension MainListTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredChracter = character?.filter { chracter in
            chracter.name.lowercased().contains(searchText.lowercased())
        } ?? []
        
        tableView.reloadData()
    }
}
