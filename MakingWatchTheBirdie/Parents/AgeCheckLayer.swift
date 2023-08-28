//
//  AgeCheckLayer.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 23.08.2023.
//

import SwiftUI

struct AgeCheckLayer: View {
    
    @Binding var accessLevel: AccessLevel
    @State var equation = AgeCheckEquationViewModel.idle
    static var equationGenerator = AgeCheckEquationGenerator()
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.5).ignoresSafeArea()
            .onTapGesture {
                accessLevel = accessLevel.cancel()
            }
            AgeCheck(accessLevel: $accessLevel, equation: equation) { isValid in
                accessLevel = isValid ? accessLevel.next() : accessLevel.cancel()
            }
        }
        .onAppear {
            equation = AgeCheckLayer.equationGenerator
                .newEquation()
                .viewModel
        }
    }
}

struct AgeCheckLayer_Previews: PreviewProvider {
    static var previews: some View {
        AgeCheckLayer(accessLevel: .constant(.kids))
    }
}
