//
//  WeatherViewModel.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 03.11.2021.
//

import UIKit

protocol WeatherViewModelDelegate: AnyObject {
    func didLoadData()
}

protocol WeatherViewModelInterface {
    var numberOfRows: Int { get }
    var location: String { get }
    func handlLoadingData()
    func object(at index: Int) -> DataCell?
    
    var delegate: WeatherViewModelDelegate? { get set }
}

final class WeatherViewModel: WeatherViewModelInterface {
    
    var delegate: WeatherViewModelDelegate?
    
    private var model: WeatherModel
    private let networkManager = NetworkManager()
    private let dateConverter = DateConverter()
    
    init(with model: WeatherModel = .init()) {
        self.model = model
    }
    
    // MARK: WeatherViewModelInterface
    
    var numberOfRows: Int {
        return model.dataCells.count
    }
    
    var location: String {
        model.location?.name ?? ""
    }
    
    func handlLoadingData() {
        
        networkManager.getLocation(name: "Kharkiv") { location, error in
            if let error = error {
                print(error)
            }
            guard let location = location else { return }
            
            self.model.location = location
            self.networkManager.getWeathers(id: location.id) { weather, error in
                if let error = error {
                    print(error)
                }
                guard let weather = weather else { return }
                
                self.model.dataCells.removeAll()
                for weather in weather.weathers {
                    let currentTemp = String(format: "%.0f", weather.temp) + "°"
                    let minTemp = "L:" + String(format: "%.0f", weather.minTemp) + "°"
                    let maxTemp = "H:" + String(format: "%.0f", weather.maxTemp) + "°"
                    let nameOfDay = self.dateConverter.dayOfWeek(dateString: weather.applicableDate)
                    let dataCell = DataCell(currentTemp: currentTemp,
                                            minTemp: minTemp,
                                            maxTemp: maxTemp,
                                            stateName: weather.stateName,
                                            stateAbbreviate: weather.stateAbbreviate,
                                            nameOfDay: nameOfDay)
                    self.model.dataCells.append(dataCell)
                }
                
                self.delegate?.didLoadData()
            }
        }
    }
    
    func object(at index: Int) -> DataCell? {
        model.dataCells[index]
    }
}
