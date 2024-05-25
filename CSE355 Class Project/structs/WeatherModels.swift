//
//  WeatherModels.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 4/12/24.
//

struct WeatherData: Codable {
    let coord: Coordinate
    let weather: [WeatherCondition]
    let main: MainWeather
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: SystemInfo
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

struct WeatherCondition: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainWeather: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }

    var tempFahrenheit: Double {
        return (temp - 273.15) * 9/5 + 32
    }

    var tempMinFahrenheit: Double {
        return (tempMin - 273.15) * 9/5 + 32
    }

    var tempMaxFahrenheit: Double {
        return (tempMax - 273.15) * 9/5 + 32
    }
}


struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}

struct SystemInfo: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
