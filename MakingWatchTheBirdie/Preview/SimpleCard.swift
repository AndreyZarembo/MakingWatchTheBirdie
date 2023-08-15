//
//  SimpleCard.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 09.08.2023.
//

import SwiftUI

struct SimpleCard: View {
    var body: some View {
        GeometryReader { gr in
            
            if gr.size.width > 200 {
                HStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(24)
                    Text("Watch\nThe\nBirdie").font(.title)
                    .frame(width: 100)
                }
            }
            else {
                VStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(24)
                    Text("Watch\nThe\nBirdie").font(.title)
                }
            }   
        }
    }
}

struct Wide_Preview: PreviewProvider {
    static var previews: some View {
        SimpleCard()
        .previewDisplayName("Wide")
        .previewLayout(.fixed(width: 210, height: 400))
    }
}

#Preview("Narrow", traits: .fixedLayout(width: 190, height: 400)) {
    SimpleCard()
}
