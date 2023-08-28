//
//  AgeCheckAnswerButton.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.08.2023.
//

import SwiftUI

struct AgeCheckAnswerButton: View {

    var answer: String
    var isValid: Bool = false
    var action: (_ isValid: Bool) -> Void


    var body: some View {

        Button {
            
            action(isValid)
            
        } label: {
            Text(answer)
            .foregroundColor(.white)
            .font(.title2)
            .bold()
        }
        .frame(width: 48, height: 48)
        .background {
            Color.white.opacity(0.3).cornerRadius(12)
        }
    }
}

struct AgeCheckAnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        AgeCheckAnswerButton(answer: "C", isValid: false) { isValid in
        }
        .background {
            Color.black
        }
    }
}
