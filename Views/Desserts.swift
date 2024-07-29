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
                    Text(dessert.strMeal)
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
