//
//  AccessLevelStates.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.08.2023.
//

import Foundation

extension AccessLevel {
    
    func next() -> AccessLevel {
        switch self {
        case .kids: return .ageCheck
        case .ageCheck: return .parent
        case .parent: return .kids
        }
    }
    
    func cancel() -> AccessLevel {
        switch self {
        case .ageCheck: return .kids
        default: return self
        }
    }
    
}
