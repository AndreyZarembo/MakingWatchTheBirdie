//
//  MapDemo.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 13.09.2023.
//

import SwiftUI

struct MapDemo: View {
    var body: some View {
        
        Text("Map")
        .font(.largeTitle)
        
        VStack {
            PublisherPreview(items: [
                .item(color: .red, icon: .none),
                .item(color: .blue, icon: .none),
                .delay,
                .item(color: .green, icon:  .none),
            ])
         
            Operation(equation: ".map")
            
            PublisherPreview(items: [
                .item(color: .red, icon: .star),
                .item(color: .blue, icon: .star),
                .delay,
                .item(color: .green, icon:  .star),
            ])
            
            Spacer()
        }
    }
}

#Preview {
    MapDemo()
}
