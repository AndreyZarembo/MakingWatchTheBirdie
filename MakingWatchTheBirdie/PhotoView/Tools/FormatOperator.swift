//
//  FormatOperator.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 05.09.2023.
//

import Foundation

func %(value: any Numeric, format:String) -> String {
    return String(format: format, value as! CVarArg)
}

extension Numeric {
    
    var sh: String {
        return self % "%.2f"
    }
}
