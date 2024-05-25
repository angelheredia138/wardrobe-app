//
//  ClothingItemView.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 4/13/24.
//

import SwiftUI

struct ClothingItemView: View {
    let item: ClothingItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                } else {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }

                Group {
                    Text("Name: \(item.name ?? "Unknown")").font(.headlineStyle)
                    Text("Type: \(item.type ?? "N/A")").font(.bodyStyle)
                    Text("Size: \(item.size ?? "N/A")").font(.bodyStyle)
                    Text("Color: \(item.color ?? "N/A")").font(.bodyStyle)
                    Text("Weather Type: \(item.weatherType ?? "N/A")").font(.bodyStyle)
                }
            }
            .padding()
        }
        .navigationTitle(item.name ?? "Clothing Item")
        .navigationBarTitleDisplayMode(.inline)
    }
}







