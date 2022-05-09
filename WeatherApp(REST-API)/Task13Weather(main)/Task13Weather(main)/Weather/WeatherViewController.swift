//
//  WeatherViewController.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 03.11.2021.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let todayCell = "TodayCell"
        static let otherDaysCell = "OtherDaysCell"
    }
    
    // MARK: - UI element
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    private lazy var refreshControl = UIRefreshControl(frame: .zero, primaryAction: UIAction(handler: refreshHandler))
    
    private lazy var activityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Variable
    
    private var viewModel = WeatherViewModel()
    private let networkManager = NetworkManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConstraint()
        viewModel.delegate = self
        viewModel.handlLoadingData()
        activityIndicatorView.startAnimating()
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        view.addSubview(tableView)
        tableView.addSubview(activityIndicatorView)
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.register(TodayTableViewCell.self, forCellReuseIdentifier: Configuration.todayCell)
        tableView.register(OtherDaysTableViewCell.self, forCellReuseIdentifier: Configuration.otherDaysCell)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }
    
    // MARK: - UIAction
    
    private func refreshHandler(_ action: UIAction) {
        viewModel.handlLoadingData()
    }
}

// MARK: - UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case .zero:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Configuration.todayCell) as? TodayTableViewCell else { return UITableViewCell() }
            cell.setup(location: viewModel.location,
                       dataCell: viewModel.object(at: indexPath.item))
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Configuration.otherDaysCell) as? OtherDaysTableViewCell else { return UITableViewCell() }
            
            cell.setup(dataCell: viewModel.object(at: indexPath.item - 1))
            
            return cell
        }
    }
}

// MARK: - WeatherViewModelDelegate

extension WeatherViewController: WeatherViewModelDelegate {    
    func didLoadData() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
        self.activityIndicatorView.stopAnimating()
    }
}
