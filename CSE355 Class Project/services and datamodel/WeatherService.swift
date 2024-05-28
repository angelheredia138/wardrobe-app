//
//  WeatherService.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 4/12/24.
//

import Foundation
import CoreLocation

class WeatherService {
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let apiKey = ""
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        print("Fetching weather from URL: \(url)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Weather fetch failed: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}


