# Wardrobe and Weather App

This iOS app combines wardrobe management with weather forecasting to suggest appropriate clothing based on current weather conditions. It utilizes Core Data for persistent storage, SwiftUI for the UI, and integrates weather API for live weather updates.

## Features

- **Wardrobe Management**: Users can add, view, and delete clothing items from their wardrobe. Each item includes details such as name, type, size, color, and an image.
- **Weather Forecast**: Displays current weather data including temperature, conditions, and provides custom clothing suggestions from the user's wardrobe.
- **Clothing Suggestions**: Based on the current temperature, the app suggests suitable clothing items. It supports cold, temperate, and warm weather conditions.
- **Add Clothing**: Users can add new clothing items to their wardrobe with details and photos.
- **View Clothing Details**: Users can view details of each clothing item in a separate detailed view.

## Architecture

The app is built using the MVVM (Model-View-ViewModel) architecture to ensure clean separation of concerns and enhance maintainability. 

- **Model**: Handles the data logic, interfacing with the Core Data stack.
- **View**: Provides the user interface elements, crafted entirely in SwiftUI for a responsive and state-driven design.
- **ViewModel**: Serves as the intermediary between the model and the view, managing the data flow and transformations.

## Setup

1. Clone the repository:
git clone https://github.com/angelheredia138/wardrobe-app.git
2. Open `WardrobeWeather.xcodeproj` in Xcode.
3. Build and run the project on a compatible iOS simulator or a physical device.

## Dependencies

- SwiftUI
- CoreData
- CoreLocation for location-based weather data.


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgements

- Weather data provided by [OpenWeatherMap API](https://openweathermap.org/).
- Icons and images are designed by the developer or sourced from royalty-free image sites as appropriate.
