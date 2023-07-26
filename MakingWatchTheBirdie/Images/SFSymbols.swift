//
//  SFSymbols.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 25.07.2023.
//

import SwiftUI

struct SFSymbols: View {
    var body: some View {
        VStack {
            Image(systemName: "cloud.rain")
                .imageScale(.large)
            
            Image(systemName: "flag.2.crossed")
                .imageScale(.large)
                .foregroundColor(Color.blue)
            
            Image(systemName: "heart.fill")
                .symbolRenderingMode(.multicolor)
        
        }
    }
}

struct SFSymbols_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbols()
    }
}
