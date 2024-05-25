//
//  WeatherDetailsView.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 4/14/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct WeatherDetailsView: View {
    var weather: WeatherData
    var recommendationText: String?
    var recommendedClothingItems: [ClothingItem]
    var userLocation: CLLocationCoordinate2D

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Current Temperature: \(weather.main.tempFahrenheit, specifier: "%.1f")°F")
                Text("Description: \(weather.weather.first?.description.capitalized ?? "N/A")")
                Text("Min Temperature: \(weather.main.tempMinFahrenheit, specifier: "%.1f")°F")
                Text("Max Temperature: \(weather.main.tempMaxFahrenheit, specifier: "%.1f")°F")
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.appBackground))
            .foregroundColor(.appAccent)
            .shadow(radius: 5)

            if let recommendationText = recommendationText {
                Text(recommendationText)
                    .font(.headline)
                    .foregroundColor(Color.green)
                    .padding()

                if !recommendedClothingItems.isEmpty {
                    NavigationLink(destination: RecommendedClothingView(clothingItems: recommendedClothingItems)) {
                        Text("View Recommended Clothing")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                } else {
                    Text("No clothing that matches the weather conditions. Try adding some clothes!")
                        .foregroundColor(.red)
                        .padding()
                }
            }

            MapView(userLocation: userLocation)
                .frame(height: 200)
                .padding()

            Spacer()
        }
        .padding()
        .navigationBarTitle("Weather Details")
    }
}

struct MapView: View {
    var userLocation: CLLocationCoordinate2D

    var body: some View {
        Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: userLocation,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            ),
            annotationItems: [UserLocationAnnotation(coordinate: userLocation)]) { location in
                MapPin(coordinate: location.coordinate, tint: .blue)
            }
            .edgesIgnoringSafeArea(.all)
    }
}

struct UserLocationAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}






