//
//  Divider.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

///Custom Divider Between Login & Sign in Buttons
struct CustomDivider: View {
    var body: some View {
        HStack(spacing:5){
            Rectangle()
                .frame(width: 120, height: 1, alignment: .center)
            
            Text("Or")
                .font(.caption).foregroundColor(.secondary)
            
            Rectangle()
                .frame(width: 120, height: 1, alignment: .center)
        }
        .padding(.vertical,10)
    }
}
