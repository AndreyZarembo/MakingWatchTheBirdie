//
//  Timing.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 15.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var timing: OperationInfoCollection = OperationInfoCollection(
        title: "Timing",
        operations: [
            
            OperationInfo(
                title: "Measure Interval",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                    .item(color: .green, icon: .triangle),
                                ])
                        ],
                        equation: "a.measureInterval()",
                        output: .stringResult { inputs in
                            inputs["a"]!
                            .measureInterval(using: RunLoop.main)
                            .reduce("") { res, dT in
                                var newRes = res
                                newRes += (res.count > 0 ? "\n" : "") +
                                    String(format: "%.02fc", dT.timeInterval)
                                return newRes
                            }
                        }),
                ]),
            
            OperationInfo(
                title: "Debounce",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                    .delay,
                                    .item(color: .green, icon: .triangle),
                                    .item(color: .teal, icon: .none),
                                    .item(color: .yellow, icon: .star),
                                    .delay,
                                    .item(color: .purple, icon: .triangle),
                                ])
                        ],
                        equation: "a.debounce(0.01, main)",
                        output: .publisher { inputs in
                            inputs["a"]!
                            .debounce(for: .seconds(0.01), scheduler: RunLoop.main)
                        }),
                ]),
            
            OperationInfo(
                title: "Delay",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .red, icon: .asterisk),
                                    .delay,
                                    .item(color: .red, icon: .triangle),
                                ]),
                            
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .blue, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                    .delay,
                                    .item(color: .blue, icon: .triangle),
                                ]),
                        ],
                        equation: "a.delay(0.02).merge(b)",
                        output: .publisher { inputs in
                            inputs["a"]!
                            .delay(for: .seconds(0.02), scheduler: RunLoop.main)
                            .merge(with: inputs["b"]!)
                        }),
                ]),
            
            
            OperationInfo(
                title: "Throttle",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .green, icon: .asterisk),
                                    .item(color: .blue, icon: .triangle),
                                    .item(color: .purple, icon: .none),
                                    .item(color: .teal, icon: .star),
                                    .item(color: .orange, icon: .asterisk)
                                ]),
                        ],
                        equation: "a.throttle(0.02, main, latest)",
                        output: .publisher { inputs in
                            inputs["a"]!
                            .throttle(for: .seconds(0.02), scheduler: RunLoop.main, latest: true)
                        }),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .green, icon: .asterisk),
                                    .item(color: .blue, icon: .triangle),
                                    .item(color: .purple, icon: .none),
                                    .item(color: .teal, icon: .star),
                                    .item(color: .orange, icon: .asterisk)
                                ]),
                        ],
                        equation: "a.throttle(0.02, main, first)",
                        output: .publisher { inputs in
                            inputs["a"]!
                            .throttle(for: .seconds(0.02), scheduler: RunLoop.main, latest: false)
                        }),
                    
                ]),
            
            OperationInfo(
                title: "Timeout",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .green, icon: .asterisk),
                                    .delay,
                                    .item(color: .orange, icon: .asterisk),
                                ]),
                        ],
                        equation: "a.timeout(0.02, main, black error",
                        output: .publisher { inputs in
                            inputs["a"]!
                            .timeout(.seconds(0.02), scheduler: RunLoop.main) {
                                .error(color: .black)
                            }
                        }),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "b",
                                items: [
                                    .delay,
                                    .delay,
                                    .delay,
                                    .item(color: .red, icon: .star),
                                    .item(color: .green, icon: .asterisk),
                                ]),
                        ],
                        equation: "b.timeout(0.02, main, black error",
                        output: .publisher { inputs in
                            inputs["b"]!
                            .timeout(.seconds(0.02), scheduler: RunLoop.main) {
                                .error(color: .black)
                            }
                        }),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .green, icon: .asterisk),
                                    .delay,
                                    .delay,
                                    .item(color: .orange, icon: .asterisk),
                                ]),
                        ],
                        equation: "c.timeout(0.02, main, black error",
                        output: .publisher { inputs in
                            inputs["c"]!
                            .timeout(.seconds(0.02), scheduler: RunLoop.main) {
                                .error(color: .black)
                            }
                        }),
                ]),
        ])
}

#Preview {
    CombineDemo(collections: [SwiftCombineDemo.timing])
}
