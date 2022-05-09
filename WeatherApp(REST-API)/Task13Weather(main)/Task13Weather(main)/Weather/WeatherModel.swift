//
//  WeatherModel.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 03.11.2021.
//

import UIKit

struct WeatherModel {
    var location: Location?
    var dataCells: [DataCell] = []
}

struct DataCell {
    var currentTemp: String
    let minTemp: String
    let maxTemp: String
    let stateName: String
    let stateAbbreviate: String
    let nameOfDay: String
}
