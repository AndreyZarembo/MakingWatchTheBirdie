//
//  Operations.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 13.09.2023.
//

import Foundation
import SwiftUI

struct OperationInfoExample: Hashable {
    let inputs: [Input]
    let equation: String
    let output: OutputType
    
    static func == (lhs: OperationInfoExample, rhs: OperationInfoExample) -> Bool {
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(equation.hashValue)
    }
}

struct OperationInfo: Hashable {
    
    let id: UUID = UUID()
    let title: String
    let examples: [OperationInfoExample]
    
    static func == (lhs: OperationInfo, rhs: OperationInfo) -> Bool {
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id.hashValue)
    }
}

struct OperationInfoDemo: View {
    
    @State var info: OperationInfo
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                Text(info.title)
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 0))
                
                ForEach(info.examples.indices, id: \.self) { exampleId in
                    let example = info.examples[exampleId]
                    Text(example.equation)
                        .font(.title2)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 0))
                    OperationDemo(inputs: example.inputs, equation: example.equation, output: example.output)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 48, trailing: 0))
                }
            }
        }
    }
}
    
