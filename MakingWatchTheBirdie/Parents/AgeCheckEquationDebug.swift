//
//  AgeCheckEquationDebug.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.08.2023.
//

import Foundation

extension AgeCheckEquationViewModel {
    
    static var debug: AgeCheckEquationViewModel {
        return AgeCheckEquationViewModel(A: "8", B: "7", Operation: "+", answers: [
            AgeCheckEquationAnswer(value: "15", isValid: true),
            AgeCheckEquationAnswer(value: "14", isValid: false),
            AgeCheckEquationAnswer(value: "16", isValid: false),
        ])
    }
}
