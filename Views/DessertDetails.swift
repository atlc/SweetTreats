//
//  DessertDetails.swift
//  SweetTreats
//
//  Created by user263110 on 7/29/24.
//

import Foundation
import SwiftUI

struct DessertDetailsView: View {
    @StateObject private var detailsViewModel = DessertDetailsViewModel()
    
    var id: String
    
    private var dessert: DessertDetails {
        return detailsViewModel.dessert
    }
    
    var body: some View {
            Text(dessert.strMeal ?? "Dessert Details").bold().onAppear{
                Task {
                    await detailsViewModel.getDetails(id: id)
                }
            }
        
        // Default value is a Creative Commons image
        // https://commons.wikimedia.org/wiki/File:12_Course_Table_Setting.jpg
        AsyncImage(url: URL(string: dessert.strMealThumb ?? "https://upload.wikimedia.org/wikipedia/commons/6/6a/12_Course_Table_Setting.jpg")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        } placeholder: {
            ProgressView()
        }
            if !(dessert.strInstructions?.isEmptyOrNilOrWhitespace ?? true) {
                Text("Directions:\n").bold().italic()
                Text(dessert.strInstructions!.replacingOccurrences(of: "\n", with: "\n\n")).italic()
            }
                     
        if detailsViewModel.ingredients.count > 0 {
            Text("Ingredients:\n").bold().italic()

            List(detailsViewModel.ingredients, id: \.self) { ing in
                Text(ing)
            }
        }
        
    }
}

