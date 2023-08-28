//
//  AgeCheckEquationGenerator.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.08.2023.
//

import Foundation


struct AgeCheckEquationGenerator {
    
    static var variantsCount = 3
    
    func newEquation() -> AgeCheckEquation {
        
        let operation = AgeCheckOperation.random
        var (a, b, result) = {
            while true  {
                let generatedABR = generationStep(operation)
                if generatedABR.result > 10 {
                    return generatedABR
                }
            }
        }()
        
        if operation == .divide || operation == .minus {
            let tmp = a
            a = result
            result = tmp
        }

        let variants: [Int] = (0..<AgeCheckEquationGenerator.variantsCount-1)
            .reduce([], { partialResult, _ in
                return partialResult + [self.generateVariant(from: result, partialResult, operation)]
            })

        let order = (0..<(AgeCheckEquationGenerator.variantsCount)).shuffled()
        
        let equation = AgeCheckEquation(a: a, b: b, answer: result, variants: variants, order: order, operation: operation)
        print(equation)
        return equation
    }
    
    private func generateVariant(from result: Int, _ previous: [Int], _ operation: AgeCheckOperation) -> Int {
        
        while true {
            let variant = result + Int.random(in: -1...1) * Int.random(in: 1...9)
            
            let min: Int
            
            switch operation {
            case .plus: min = 10
            case .multiply: min = 10
            case .divide: min = 1
            case .minus: min = 1
            }
            
            if variant != result, variant >= min, variant <= 99, !previous.contains(variant) {
                return variant
            }
        }
    }
    
    private func generationStep(_ operation: AgeCheckOperation) -> (a: Int, b: Int, result: Int) {
        
        let a = Int.random(in: 1...9)
        let b = Int.random(in: 1...9)
        let result: Int
        if operation == .minus || operation == .divide {
            result = operation.invert.perform(a, b)
        }
        else {
            result = operation.perform(a, b)
        }
        
        return (a: a, b: b, result: result)
    }
}
