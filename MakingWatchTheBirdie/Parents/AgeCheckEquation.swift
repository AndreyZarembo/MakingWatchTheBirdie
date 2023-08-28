//
//  AgeCheckEquation.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.08.2023.
//

import SwiftUI

struct AgeCheckEquation {
    let a: Int
    let b: Int
    let answer: Int
    let variants: [Int]
    let order: [Int]
    let operation: AgeCheckOperation
}

struct AgeCheckEquationViewModel {
    
    let A: String
    let B: String
    let Operation: String
    
    let answers: [AgeCheckEquationAnswer]
    
}

struct AgeCheckEquationAnswer: Identifiable {
    
    let id: UUID = UUID()
    let value: String
    let isValid: Bool
    
}

extension AgeCheckEquation {
    
    var viewModel: AgeCheckEquationViewModel {
        return AgeCheckEquationViewModel(
            A: "\(self.a)",
            B: "\(self.b)",
            Operation: self.operation.symbol,
            answers: self.order.map { index in
                
                if index == 0 {
                    return AgeCheckEquationAnswer(value: "\(self.answer)", isValid: true)
                }
                else {
                    return AgeCheckEquationAnswer(value: "\(self.variants[index-1])", isValid: false)
                }
            }
        )
    }
}


extension AgeCheckEquationViewModel {
    
    static var idle: AgeCheckEquationViewModel {
        return AgeCheckEquationViewModel(A: "", B: "", Operation: "", answers: [])
    }
}
