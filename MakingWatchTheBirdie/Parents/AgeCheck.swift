//
//  AgeCheck.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 23.08.2023.
//

import SwiftUI

struct AgeCheck: View {
    
    @Binding var accessLevel: AccessLevel
    var equation: AgeCheckEquationViewModel
    var action: (_ isValid: Bool) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            
            Text("Ask Parent to solve equation")
            .foregroundColor(.white)
            .font(.headline)
            .bold()
            
            HStack(spacing: 4) {
                Text(equation.A)
                .foregroundColor(.white)
                .font(.title2)
                .bold()
                
                Text(equation.Operation)
                .foregroundColor(.white)
                .font(.title)
                .bold()
                
                Text(equation.B)
                .foregroundColor(.white)
                .font(.title2)
                .bold()
                
                Text("=")
                .foregroundColor(.white)
                .font(.title2)
                .bold()
                
                HStack {
                    
                    ForEach(equation.answers) { answer in
                        
                        AgeCheckAnswerButton(
                            answer: answer.value,
                            isValid: answer.isValid,
                            action: action
                        )
                    }
                }
            }
            
        }
        .frame(width: 300)
        .padding(16)
        .overlay {
            
            RoundedRectangle(cornerRadius: 10)
            .stroke(.white, lineWidth: 3)
            .padding(3)
        }
        .background {
            GeometryReader { gr in
                ZStack {
                    AgeCheckBackground()
                    ToolbarPattern(
                        pattern: .questions,
                        toolbarSize: CGSize(
                            width: gr.size.width,
                            height: gr.size.height
                        )
                    )
                    .opacity(0.15)
                }
                .cornerRadius(12)
            }
        }
    }
}

struct AgeCheck_Previews: PreviewProvider {
    static var previews: some View {
        AgeCheck(
            accessLevel: .constant(.kids),
            equation: AgeCheckEquationViewModel.debug
        ) { isValid in
            
        }
    }
}
