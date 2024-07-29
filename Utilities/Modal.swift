//
//  Modal.swift
//  SweetTreats
//
//  Created by user263110 on 7/29/24.
//

import Foundation
import SwiftUI

struct Modal: View {
    @Environment(\.dismiss) var dismiss
    let text: String
    
    var body: some View {
        VStack {
            Text(text)
            Button(action: {
                dismiss()
            }) {
                Text("Return to recipe")
            }
        }
        .padding(.horizontal, 25)
    }
}


