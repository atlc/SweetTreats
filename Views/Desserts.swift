//
//  Desserts.swift
//  SweetTreats
//
//  Created by user263110 on 7/28/24.
//

import Foundation
import SwiftUI

struct DessertsView: View {
    @StateObject private var dessertsViewModel = DessertsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(dessertsViewModel.desserts, id: \.idMeal) { dessert in
                    NavigationLink(
                        destination: DessertDetailsView(id: dessert.idMeal),
                        label: {
                            Text(dessert.strMeal)
                        }
                    )
                    
                    AsyncImage(url: URL(string: dessert.strMealThumb)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
        .onAppear{
            Task {
                await dessertsViewModel.getAll()
            }
        }
    }
}
