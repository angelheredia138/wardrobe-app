//
//  RecommendedClothingView.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 4/14/24.
//

import SwiftUI

struct RecommendedClothingView: View {
    var clothingItems: [ClothingItem]

    var body: some View {
        List(clothingItems, id: \.self) { item in
            HStack {
                if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                } else {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
                VStack(alignment: .leading) {
                    Text(item.name ?? "Unknown")
                        .font(.headline)
                    Text("Type: \(item.type ?? "N/A")")
                    Text("Size: \(item.size ?? "N/A")")
                    Text("Color: \(item.color ?? "N/A")")
                    Text("Weather Type: \(item.weatherType ?? "N/A")")
                }
            }
        }
        .navigationBarTitle("Recommended Clothing", displayMode: .inline)
    }
}

