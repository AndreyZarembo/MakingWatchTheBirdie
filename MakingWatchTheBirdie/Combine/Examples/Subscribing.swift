//
//  Subscribing.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 15.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var subscribing: OperationInfoCollection = OperationInfoCollection(
        title: "Republishing by Subscribing",
        operations: [
            
            OperationInfo(
                title: "Flat Map",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                    .item(color: .green, icon: .triangle),
                                ]),
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                    .item(color: .cyan, icon: .number(value: 3)),
                                ])
                        ],
                        equation: "a.flatMap() { b }",
                        output: .publisher { inputs in
                            inputs["a"]!.flatMap { item in
                                return inputs["b"]!
                            }
                        }),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                    .item(color: .green, icon: .triangle),
                                ]),
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                    .item(color: .cyan, icon: .number(value: 3)),
                                ])
                        ],
                        equation: "a.flatMap(maxPublishers: 1) { b }",
                        output: .publisher { inputs in
                            inputs["a"]!.flatMap(maxPublishers: .max(1)) { item in
                                return inputs["b"]!
                            }
                        })
                ]),
            
            
            OperationInfo(
                title: "Switch To Latest",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .none),
                                    .item(color: .red, icon: .none),
                                    .delay,
                                    .item(color: .red, icon: .none),
                                    .item(color: .red, icon: .none),
                                    .item(color: .red, icon: .none),
                                ]),
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .yellow, icon: .number(value: 1)),
                                    .item(color: .yellow, icon: .number(value: 2)),
                                    .item(color: .yellow, icon: .number(value: 3)),
                                    .item(color: .yellow, icon: .number(value: 4)),
                                    .item(color: .yellow, icon: .number(value: 5)),
                                ]),
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .teal, icon: .number(value: 1)),
                                    .item(color: .teal, icon: .number(value: 2)),
                                    .item(color: .teal, icon: .number(value: 3)),
                                    .item(color: .teal, icon: .number(value: 4)),
                                    .item(color: .teal, icon: .number(value: 5)),
                                ])
                        ],
                        equation: "a.scan(0){+1}.map {b/c}.switchToLatest()",
                        output: .publisher { inputs in
                            
                            inputs["a"]!
                            .scan(0) { res, _ in
                                return res+1
                            }
                            .map { index in
                                return index % 2 != 0 ? inputs["b"]! : inputs["c"]!
                            }
                            .switchToLatest()
                            
                        }),
                ])
        ])
}

#Preview {
    CombineDemo(collections: [SwiftCombineDemo.subscribing])
}
