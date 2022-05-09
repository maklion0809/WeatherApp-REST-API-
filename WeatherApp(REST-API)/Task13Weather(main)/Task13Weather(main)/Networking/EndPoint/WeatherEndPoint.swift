//
//  WeatherEndPoint.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 04.11.2021.
//

import Foundation

enum WeatherApi {
    case location(name: String)
    case weatherForDays(id: Int)
    case weatherState(abr: String)
}

extension WeatherApi: EndPoint {
    var baseURL: URL {
        guard let url = URL(string: "https://www.metaweather.com") else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .location(let name):
            return "/api/location/search/?query=\(name)"
        case .weatherForDays(let id):
            return "/api/location/\(id)/"
        case .weatherState(let abr):
            return "/static/img/weather/png/\(abr).png"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

