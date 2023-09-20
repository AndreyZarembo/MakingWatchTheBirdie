//
//  Aggregate.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 14.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var math: OperationInfoCollection = OperationInfoCollection(
        title: "Math",
        operations: [
            
            OperationInfo(
                title: "Count",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "a.count()",
                        output: .int { inputs in
                            inputs["a"]!.count()
                        }
                    )
                ]),
            
            OperationInfo(
                title: "Max",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "a.max()",
                        output: .publisher { inputs in
                            inputs["a"]!.compactMap { $0 }.max().map { $0 as Item? }
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "b.max( red x10 )",
                        output: .publisher { inputs in
                            inputs["b"]!.compactMap { $0 }.max { a,b in
                                
                                if case let .item(a_color, a_icon) = a, case let .item(b_color, b_icon) = b,
                                   case let .number(a_value) = a_icon, case let .number(b_value) = b_icon {
                                    
                                    let aVal = a_color == .red ? a_value * 10 : a_value
                                    let bVal = b_color == .red ? b_value * 10 : b_value
                                    return aVal < bVal
                                }
                                else {
                                    return a < b
                                }
                            }.map { $0 as Item? }
                        }
                    )
                ]),
            
            OperationInfo(
                title: "Min",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "a.min()",
                        output: .publisher { inputs in
                            inputs["a"]!.compactMap { $0 }.min().map { $0 as Item? }
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "b.min( red x10 )",
                        output: .publisher { inputs in
                            inputs["b"]!.compactMap { $0 }.min { a,b in
                                
                                if case let .item(a_color, a_icon) = a, case let .item(b_color, b_icon) = b,
                                   case let .number(a_value) = a_icon, case let .number(b_value) = b_icon {
                                    
                                    let aVal = a_color == .red ? a_value * 10 : a_value
                                    let bVal = b_color == .red ? b_value * 10 : b_value
                                    return aVal < bVal
                                }
                                else {
                                    return a < b
                                }
                            }.map { $0 as Item? }
                        }
                    )
                ]),
        ])
}


#Preview {
    CombineDemo(collections: [SwiftCombineDemo.math])
}
