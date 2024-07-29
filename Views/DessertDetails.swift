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
    @State private var showFullDescription = false
    
    
    var id: String
    
    private var dessert: DessertDetails {
        return detailsViewModel.dessert
    }
    
    var body: some View {
        // Default value is a Creative Commons image
        // https://commons.wikimedia.org/wiki/File:12_Course_Table_Setting.jpg
        AsyncImage(url: URL(string: dessert.strMealThumb ?? "https://upload.wikimedia.org/wikipedia/commons/6/6a/12_Course_Table_Setting.jpg")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        } placeholder: {
            ProgressView()
        }
        
        Text(dessert.strMeal ?? "Dessert Details").bold().onAppear{
            Task {
                await detailsViewModel.getDetails(id: id)
            }
        }
    
        if detailsViewModel.hasSteps {
            Text("Instructions:").italic().bold().padding(.top, 30)
            Text("\(detailsViewModel.dessert.strInstructions!.prefix(200))...")
                .padding(.horizontal, 25)
            Button(action: {
                showFullDescription.toggle()
            }) {
                Text("See more")
            }
            .sheet(isPresented: $showFullDescription) {
                Modal(text: detailsViewModel.dessert.strInstructions!)
            }
        }
    
                     
        if detailsViewModel.hasIngredients {
            Text("Ingredients:").italic().bold().padding(.top, 30)
            Text(detailsViewModel.ingredients)
        }
    }
}

