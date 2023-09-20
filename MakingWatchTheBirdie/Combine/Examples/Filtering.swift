//
//  Filtering.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 15.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var filtering: OperationInfoCollection = OperationInfoCollection(
        title: "Filtering",
        operations: [
            
            OperationInfo(
                title: "Filter",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .blue, icon: .triangle),
                                .delay,
                                .item(color: .green, icon:  .star),
                            ])
                        ], equation: "a.filter( != ▲ )",
                        output: .publisher { inputs in
                            inputs["a"]!.filter { $0!.icon != .triangle }
                        }
                    )
                ]),
            
            OperationInfo(
                title: "Compact Map",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .star),
                                .nil,
                                .item(color: .blue, icon: .star),
                                .delay,
                                .item(color: .green, icon:  .star)
                            ])
                        ],
                        equation: "a.compactMap( ★→▲ )",
                        output: .publisher { inputs in
                            inputs["a"]!.compactMap { $0?.mapOperation() }
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .star),
                                .nil,
                                .item(color: .blue, icon: .star),
                                .delay,
                                .item(color: .green, icon:  .star)
                            ])
                        ],
                        equation: "a.map( ★→▲ )",
                        output: .publisher { inputs in
                            inputs["a"]!.map { $0?.mapOperation() }
                        }
                    )
                ]),
            
            OperationInfo(
                title: "Remove Duplicates",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .none),
                                .item(color: .red, icon: .none),
                                .item(color: .blue, icon: .none),
                                .item(color: .blue, icon: .star),
                                .delay,
                                .item(color: .green, icon:  .none),
                                .item(color: .green, icon:  .none)
                            ])
                        ], equation: "a.removeDuplicates()",
                        output: .publisher { inputs in
                            inputs["a"]!.removeDuplicates()
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .none),
                                .item(color: .red, icon: .none),
                                .item(color: .blue, icon: .none),
                                .item(color: .blue, icon: .star),
                                .delay,
                                .item(color: .green, icon:  .none),
                                .item(color: .green, icon:  .none)
                            ])
                        ], equation: "b.removeDuplicates(by: сolor )",
                        output: .publisher { inputs in
                            inputs["b"]!.removeDuplicates { a, b in a?.color == b?.color }
                        }
                    )
                    
                ]),
            
            OperationInfo(
                title: "Replace Empty",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                            ])
                        ], equation: "b.replaceEmpty(with: ...orange...)",
                        output: .publisher { inputs in
                            inputs["b"]!.replaceEmpty(with: .item(color: .orange, icon: .none))
                        }
                    ),
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .none),
                                .item(color: .blue, icon: .none),
                                .delay,
                                .item(color: .green, icon:  .none),
                            ])
                        ], equation: "a.replaceEmpty(with: ...orange...)",
                        output: .publisher { inputs in
                            inputs["a"]!.replaceEmpty(with: .item(color: .orange, icon: .none))
                        }
                    )
                ]),
            
            OperationInfo(
                title: "Replace Error", 
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .none),
                                .error(color: .green),
                                .item(color: .blue, icon: .none),
                                .delay,
                                .item(color: .green, icon:  .none),
                            ])
                        ], equation: "a.replaceError(with: ...orange...)",
                        output: .publisher { inputs in
                            inputs["a"]!.replaceError(with: .item(color: .orange, icon: .star))
                            .setFailureType(to: DemoError.self)
                        }
                    ),
                    
                ])
        ])
}

#Preview {
    CombineDemo(collections: [SwiftCombineDemo.filtering])
}
