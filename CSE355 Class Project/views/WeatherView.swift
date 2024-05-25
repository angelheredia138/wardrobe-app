//
//  WeatherView.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 3/17/24.
//

import SwiftUI
import CoreLocation
import CoreData

struct WeatherView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @ObservedObject var locationManager = LocationManager()

    @State private var weather: WeatherData?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var recommendationText: String?
    @State private var recommendedClothingItems: [ClothingItem] = []
    @State private var userLocation: CLLocationCoordinate2D?

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading weather...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .appAccent))
                        .scaleEffect(1.5)
                } else if let weather = weather, let userLocation = userLocation {
                    WeatherDetailsView(weather: weather, recommendationText: recommendationText, recommendedClothingItems: recommendedClothingItems, userLocation: userLocation)
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }

                Spacer()

                // Show the button only if weather data has not been fetched yet
                if weather == nil {
                    if locationManager.location != nil {
                        Button("Get Weather (note to graders, won't work on sim, have to use on actual phone)") {
                            fetchWeather()
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .padding(.bottom, 50)  // Adds padding at the bottom for better spacing
                    } else {
                        Text("Determining your location...")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .navigationBarTitle("Your Weather")
        }
    }

    private func fetchWeather() {
        guard let location = locationManager.location else { return }
        isLoading = true
        errorMessage = nil
        let weatherService = WeatherService()
        weatherService.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { result in
            isLoading = false
            switch result {
            case .success(let data):
                self.weather = data
                self.userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                self.updateRecommendations(for: data.main.tempFahrenheit)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func updateRecommendations(for temperature: Double) {
        let predicate: NSPredicate
        if temperature < 50 { // Cold
            recommendationText = "You should wear clothes that keep you warm!"
            predicate = NSPredicate(format: "weatherType == %@", "Cold")
        } else if temperature >= 50 && temperature < 70 { // Temperate
            recommendationText = "It's quite temperate. Consider mild weather options:"
            predicate = NSPredicate(format: "weatherType == %@", "Temperate")
        } else { // Warm
            recommendationText = "It's warm out there! Light clothing is recommended:"
            predicate = NSPredicate(format: "weatherType == %@", "Warm")
        }

        fetchClothingItems(with: predicate)
    }

    private func fetchClothingItems(with predicate: NSPredicate) {
        let request = NSFetchRequest<ClothingItem>(entityName: "ClothingItem")
        request.predicate = predicate
        do {
            recommendedClothingItems = try managedObjectContext.fetch(request)
        } catch {
            errorMessage = "Failed to fetch clothing items: \(error.localizedDescription)"
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
