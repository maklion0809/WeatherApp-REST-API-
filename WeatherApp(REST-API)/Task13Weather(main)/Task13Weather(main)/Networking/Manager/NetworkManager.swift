//
//  NetworkManager.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 04.11.2021.
//

import Foundation
import UIKit

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    let router = Router<WeatherApi>()
    
    func getLocation(name: String, completion: @escaping (_ location: Location?,_ error: String?) -> ()){
        router.request(.location(name: name)) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(nil, "Please check your network connection.")
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            let response = try JSONSerialization.jsonObject(with: responseData, options: []) as? [Any]
                            guard let reponseDic = response?[0] as? Parameters else { return }
                            let decoder = JSONDecoder()
                            let correctData = try JSONSerialization.data(withJSONObject: reponseDic, options: [])
                            let location = try decoder.decode(Location.self, from: correctData)
                            
                            completion(location, nil)
                        }catch {
                            print(error)
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
    }
    
    func getWeathers(id: Int, completion: @escaping (_ weather: WeatherForDays?,_ error: String?) -> ()) {
        router.request(.weatherForDays(id: id)) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(nil, "Please check your network connection.")
                }
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            let responseJSON = try JSONDecoder().decode(WeatherForDays.self, from: responseData)
                            
                            completion(responseJSON, nil)
                        }catch {
                            print(error)
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
