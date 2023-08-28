//
//  AgeCheckOperation.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.08.2023.
//

import Foundation

enum AgeCheckOperation {
    case plus
    case minus
    case multiply
    case divide
}

extension AgeCheckOperation {
    func perform(_ a: Int, _ b: Int) -> Int {
        switch self {
        case .plus: return a+b
        case .minus: return a-b
        case .multiply: return a*b
        case .divide: return a/b
        }
    }
}

extension AgeCheckOperation {
    
    static var random: AgeCheckOperation {
        switch Int.random(in: 0..<4) {
        case 0: return .plus
        case 1: return .minus
        case 2: return .multiply
        case 3: return .divide
        default: return .plus
        }
    }
}

extension AgeCheckOperation {
    
    var invert: AgeCheckOperation {
        switch self {
        case .plus: return .minus
        case .minus: return .plus
        case .multiply: return .divide
        case .divide: return .multiply
        }
    }
}

extension AgeCheckOperation {
    
    var symbol: String {
        switch self {
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }
}
