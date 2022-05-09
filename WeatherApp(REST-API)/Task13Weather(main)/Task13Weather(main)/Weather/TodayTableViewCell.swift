//
//  TodayTableViewCell.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 03.11.2021.
//

import UIKit

class TodayTableViewCell: UITableViewCell {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let stackViewSpacing: CGFloat = 10
        static let stackViewIndent: CGFloat = 50
        static let infofontSize: CGFloat = 30
        static let tempFontSize: CGFloat = 60
    }
    
    // MARK: - UI element
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Configuration.stackViewSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    lazy var tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Configuration.stackViewSpacing
        
        return stackView
    }()
    
    lazy var locationLabel = UILabel()
        
    lazy var stateNameLabel = UILabel()
    
    lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Configuration.tempFontSize)
        
        return label
    }()
    
    lazy var minTempLabel = UILabel()
    
    lazy var maxTempLabel = UILabel()
    
    
    // MARK: - initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        let labels = [locationLabel,
                      stateNameLabel,
                      minTempLabel,
                      maxTempLabel]
        
        for label in labels {
            label.font = .systemFont(ofSize: Configuration.infofontSize)
        }
                
        tempStackView.addArrangedSubview(minTempLabel)
        tempStackView.addArrangedSubview(maxTempLabel)
        
        mainStackView.addArrangedSubview(locationLabel)
        mainStackView.addArrangedSubview(currentTempLabel)
        mainStackView.addArrangedSubview(stateNameLabel)
        mainStackView.addArrangedSubview(tempStackView)
        contentView.addSubview(mainStackView)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Configuration.stackViewIndent),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configuration.stackViewIndent),
            mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    // MARK: - Setting up the tableViewCell
    
    func setup(location: String, dataCell: DataCell?) {
        guard let dataCell = dataCell else { return }
        
        locationLabel.text = location
        
        currentTempLabel.text = dataCell.currentTemp
        minTempLabel.text = dataCell.minTemp
        maxTempLabel.text = dataCell.maxTemp
        stateNameLabel.text = dataCell.stateName
    }
}
