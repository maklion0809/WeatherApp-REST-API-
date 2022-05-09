//
//  OtherDaysTableViewCell.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 03.11.2021.
//

import UIKit
import Kingfisher

class OtherDaysTableViewCell: UITableViewCell {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let stackViewSpacing: CGFloat = 10
        static let stackViewIndent: CGFloat = 10
        static let stackViewHeight: CGFloat = 50
    }
    
    // MARK: - UI element
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Configuration.stackViewSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var nameOfDayLabel = UILabel()
    
    private lazy var stateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private lazy var minTempLabel = UILabel()
    
    private lazy var maxTempLabel = UILabel()
    
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
        
        stackView.addArrangedSubview(nameOfDayLabel)
        stackView.addArrangedSubview(stateImageView)
        stackView.addArrangedSubview(minTempLabel)
        stackView.addArrangedSubview(maxTempLabel)
        contentView.addSubview(stackView)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Configuration.stackViewIndent),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Configuration.stackViewIndent),
            stateImageView.heightAnchor.constraint(equalToConstant: Configuration.stackViewHeight)
        ])
    }
    
    // MARK: - Setting up the tableViewCell
    
    func setup(dataCell: DataCell?) {
        guard let dataCell = dataCell else { return }
        
        nameOfDayLabel.text = dataCell.nameOfDay
        minTempLabel.text = dataCell.minTemp
        maxTempLabel.text = dataCell.maxTemp
        
        // Loading UIImageView with Kingfisher
        
        let route: WeatherApi = .weatherState(abr: dataCell.stateAbbreviate)
        let url = route.baseURL.appendingPathComponent(route.path)
        
        stateImageView.kf.indicatorType = .activity
        stateImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(1))]) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
