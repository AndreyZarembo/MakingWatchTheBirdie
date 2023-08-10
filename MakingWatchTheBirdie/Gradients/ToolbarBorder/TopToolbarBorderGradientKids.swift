//
//  TopToolbarBorderGradientKids.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import SwiftUI

struct TopToolbarBorderGradientKids: View {
    
    struct GradientStyle: View {
        var body: some View {
            Rectangle()
                .foregroundColor(.clear)
                .background(Color(red: 0.11, green: 0.22, blue: 0.45))
        }
    }
    
    var body: some View {
        ZStack {
            GradientStyle()
                .opacity(0.85)
        }
    }
}

struct TopToolbarBorderGradientKids_Previews: PreviewProvider {
    static var previews: some View {
        TopToolbarBorderGradientKids()
    }
}
