//
//  CaptureButton.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.07.2023.
//

import SwiftUI

struct CaptureButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Image("Photo Button")
            .resizable()
            .shadow(radius: configuration.isPressed ? 4 : 10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .offset(x: 0, y: configuration.isPressed ? 5: 0)
    }
}

struct CaptureButtonLayer: View {
    
    var buttonAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                buttonAction()
            } label: {
            }
            .buttonStyle(CaptureButtonStyle())
            .frame(width: 105, height: 105)
        }
    }
}

struct CaptureButton_Previews: PreviewProvider {
    static var previews: some View {
        CaptureButtonLayer {
            // Action
        }
    }
}
