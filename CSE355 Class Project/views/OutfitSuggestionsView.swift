//
//  OutfitSuggestionsView.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 3/17/24.
//

import SwiftUI

struct OutfitSuggestionsView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(
        entity: ClothingItem.entity(),
        sortDescriptors: []
    ) var clothingItems: FetchedResults<ClothingItem>
    
    @State private var recommendedOutfits: [(top: ClothingItem, bottom: ClothingItem)] = []

    var body: some View {
        NavigationView {
            List(recommendedOutfits, id: \.top.id) { outfit in
                NavigationLink(destination: OutfitDetailView(top: outfit.top, bottom: outfit.bottom)) {
                    VStack(alignment: .leading) {
                        Text("\(outfit.top.name ?? "Unknown Top") + \(outfit.bottom.name ?? "Unknown Bottom")")
                            .font(.titleStyle)
                            .foregroundColor(.appPrimary)
                            .padding(.bottom, 2)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Top: \(outfit.top.name ?? "Unknown")")
                                Text("Bottom: \(outfit.bottom.name ?? "Unknown")")
                            }
                            .font(.bodyStyle)
                        }
                    }
                }
            }
            .onAppear(perform: generateOutfitSuggestions)
            .navigationTitle("Outfit Suggestions")
        }
    }

    private func generateOutfitSuggestions() {
        // Existing logic to generate outfits
        print("Generating outfit suggestions...")
        recommendedOutfits = [] // Clear previous suggestions
        let tops = clothingItems.filter { $0.type == "T-Shirt" || $0.type == "Blouse" || $0.type == "Jacket" }
        let bottoms = clothingItems.filter { $0.type == "Pants" || $0.type == "Jeans" || $0.type == "Shorts" }

        for top in tops {
            for bottom in bottoms {
                if top.weatherType == bottom.weatherType && isValidPair(top: top, bottom: bottom) {
                    recommendedOutfits.append((top: top, bottom: bottom))
                }
            }
        }

        if recommendedOutfits.isEmpty {
            print("No compatible outfits found.")
        }
    }

    private func isValidPair(top: ClothingItem, bottom: ClothingItem) -> Bool {
        return !(top.type == "Jacket" && (bottom.type == "Shorts"))
    }
}

