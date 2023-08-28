//
//  AgeCheckBackground.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.08.2023.
//

import SwiftUI

struct AgeCheckBackground: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(
                    color: Color(
                        red: 128/255,
                        green: 196/255,
                        blue: 28/255),
                    location: 0),
                Gradient.Stop(
                    color: Color(
                        red: 35/255,
                        green: 125/255,
                        blue: 38/255),
                    location: 1),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay {
            Color.black.opacity(0.2)
        }
    }
}

struct AgeCheckBackground_Previews: PreviewProvider {
    static var previews: some View {
        AgeCheckBackground()
    }
}
