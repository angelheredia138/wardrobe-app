//
//  OutfitDetailView.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 4/14/24.
//

import Foundation
import SwiftUI

struct OutfitDetailView: View {
    var top: ClothingItem
    var bottom: ClothingItem

    var body: some View {
        VStack {
            Text("Suggested Outfit").font(.titleStyle)
            
            HStack {
                ItemDetailView(item: top)
                ItemDetailView(item: bottom)
            }
        }
    }
}

struct ItemDetailView: View {
    var item: ClothingItem

    var body: some View {
        VStack {
            if let imageData = item.imageData, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            } else {
                Image("placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            Text(item.name ?? "Unknown Item").font(.bodyStyle)
        }
    }
}
