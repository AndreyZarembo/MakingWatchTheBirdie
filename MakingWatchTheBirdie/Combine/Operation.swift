//
//  Operation.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 13.09.2023.
//

import SwiftUI

struct Operation: View {
    
    @State var equation: String
    
    var body: some View {
        
        ZStack {
            
            Color.black.frame(height: 2)
            
            Text(equation)
            .padding(12)
            .background(.white)
            .overlay(RoundedRectangle(cornerRadius: 12)
            .stroke(Color.black, lineWidth: 1))
        }
        
    }
}

#Preview {
    Operation(equation: ".map(a)")
}
