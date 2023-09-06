//
//  CustomContainer.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.08.2023.
//

import SwiftUI

struct CustomContainer<Content: View>: View {
    
    @ViewBuilder let content: () -> Content?
    
    var body: some View {
        VStack {
            Group(content: content)
                .frame(width: 128, height: 64)
                .background(.white)
                .cornerRadius(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black.opacity(0.05), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.1), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    CustomContainer() {
        Text("!")
        Text("?")
    }
}
