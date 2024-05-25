//
//  ContentView.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 3/17/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @StateObject var viewModel = ClothingListViewModel(context: PersistenceController.shared.container.viewContext)
    
    init() {
            // Customizing the appearance of the TabBar
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(named: "appBackground")

            // Setting default TabBar and ScrollEdgeAppearance to the new appearance
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }

    var body: some View {
        TabView {
            WardrobeView()
                .tabItem {
                    Label("Wardrobe", systemImage: "hanger")
                }
                .environmentObject(viewModel)  // Pass the ViewModel to the WardrobeView

            OutfitSuggestionsView()
                .tabItem {
                    Label("Suggestions", systemImage: "lightbulb")
                }

            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun")
                }
        }
        .environmentObject(viewModel)
        .accentColor(.appPrimary)
        .font(.headlineStyle) // Applying global font style
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentView()
}




