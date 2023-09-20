//
//  Select.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 14.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var select: OperationInfoCollection = OperationInfoCollection(
        title: "Select",
        operations: [
            
            OperationInfo(
                title: "First",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "a.first()",
                        output: .publisher { inputs in
                            inputs["a"]!.first()
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .blue, icon: .triangle),
                                .delay,
                                .item(color: .green, icon:  .triangle),
                                .item(color: .orange, icon:  .asterisk),
                            ])
                        ], equation: "b.first(where: ▲)",
                        output: .publisher { inputs in
                            inputs["b"]!.first{ item in
                                item?.icon == .triangle
                            }
                        }
                    ),
                ]),
            
            OperationInfo(
                title: "Last",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "a.last()",
                        output: .publisher { inputs in
                            inputs["a"]!.last()
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .blue, icon: .triangle),
                                .delay,
                                .item(color: .green, icon:  .triangle),
                                .item(color: .orange, icon:  .asterisk),
                            ])
                        ], equation: "b.last(where: ▲)",
                        output: .publisher { inputs in
                            inputs["b"]!.last { item in
                                item?.icon == .triangle
                            }
                        }
                    ),
                ]),
            OperationInfo(
                title: "Output",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "a.output(at: 1)",
                        output: .publisher { inputs in
                            inputs["a"]!.output(at: 1)
                        }
                    ),
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .red, icon: .number(value: 2)),
                                .item(color: .red, icon: .number(value: 3)),
                                .item(color: .red, icon: .number(value: 4)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "b.output(in: 2...4)",
                        output: .publisher { inputs in
                            inputs["b"]!.output(in: 2...4)
                        }
                    )
                ]),
            
            
        ])
}


#Preview {
    CombineDemo(collections: [SwiftCombineDemo.select])
}
