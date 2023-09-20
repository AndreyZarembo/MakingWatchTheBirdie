//
//  Reducing.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 15.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var reducing: OperationInfoCollection = OperationInfoCollection(
        title: "Reducing",
        operations: [
            
            OperationInfo(
                title: "Collect",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .none),
                                    .item(color: .blue, icon: .none),
                                    .item(color: .green, icon: .none)
                                ])
                        ],
                        equation: "a.collect()",
                        output: .publisher { inputs in
                            
                            inputs["a"]!.collect().map { array in
                                Item.array(items: ItemsArray(items: array.compactMap{ $0 }) )
                            }
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .red, icon: .none),
                                    .item(color: .blue, icon: .none),
                                    .item(color: .green, icon: .none),
                                    .item(color: .orange, icon: .none),
                                    .item(color: .purple, icon: .none),
                                    .item(color: .yellow, icon: .none),
                                ])
                        ],
                        equation: "b.collect(3)",
                        output: .publisher { inputs in
                            
                            inputs["b"]!.collect(3).map { array in
                                Item.array(items: ItemsArray(items: array.compactMap{ $0 } ))
                            }
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .red, icon: .none),
                                    .item(color: .blue, icon: .none),
                                    .item(color: .green, icon: .none),
                                    .item(color: .orange, icon: .none),
                                    .item(color: .purple, icon: .none),
                                    .item(color: .yellow, icon: .none),
                                ])
                        ],
                        equation: "c.collect(4)",
                        output: .publisher { inputs in
                            
                            inputs["c"]!.collect(4).map { array in
                                Item.array(items: ItemsArray(items: array.compactMap{ $0 } ))
                            }
                        }
                    )
                    
                ]),

            OperationInfo(
                title: "Collect By Time",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .none),
                                    .item(color: .blue, icon: .none),
                                    .item(color: .green, icon: .none),
                                    .item(color: .orange, icon: .none),
                                    .item(color: .purple, icon: .none),
                                    .item(color: .yellow, icon: .none),
                                ])
                        ],
                        equation: "a.collect(.byTime(30ms)",
                        output: .publisher { inputs in
                            
                            inputs["a"]!.collect(.byTime(RunLoop.main, .milliseconds(35))).map { array in
                                Item.array(items: ItemsArray(items: array.compactMap{ $0 } ))
                            }
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .red, icon: .none),
                                    .item(color: .blue, icon: .none),
                                    .item(color: .green, icon: .none),
                                    .item(color: .orange, icon: .none),
                                    .item(color: .purple, icon: .none),
                                    .item(color: .yellow, icon: .none),
                                ])
                        ],
                        equation: "b.collect(.byTimeOrCount(30ms, 2)",
                        output: .publisher { inputs in
                            
                            inputs["b"]!.collect(.byTimeOrCount(RunLoop.main, .milliseconds(35), 2)).map { array in
                                Item.array(items: ItemsArray(items: array.compactMap{ $0 }) )
                            }
                        }
                    ),
                ]),
            
                OperationInfo(title: "Ignore Output", examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .none),
                                    .item(color: .blue, icon: .none),
                                ])
                        ],
                        equation: "a.ignoreOutput()",
                        output: .publisher { inputs in
                            
                            inputs["a"]!.ignoreOutput()
                            .map{ _ in Item.delay }

                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .red, icon: .none),
                                    .error(color: .red),
                                    .item(color: .blue, icon: .none),
                                ])
                        ],
                        equation: "b.ignoreOutput()",
                        output: .publisher { inputs in
                            
                            inputs["b"]!.ignoreOutput()
                            .map{ _ in Item.delay }

                        }
                    ),
                
                ]),
            
            OperationInfo(
                title: "Reduce",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .number(value: 1)),
                                    .item(color: .green, icon: .number(value: 2)),
                                    .item(color: .blue, icon: .number(value: 3)),
                                ])
                        ],
                        equation: "a.reduce(0, +n)",
                        output: .int(operation: { inputs in
                            inputs["a"]!.reduce(0) { res, item in
                                guard let _item = item, case let .item(_, icon) = item, case let .number(value) = icon else {
                                    return res
                                }
                                return res + value
                            }
                        }))
                
                ]),
        ])
}


#Preview {
    CombineDemo(collections: [SwiftCombineDemo.reducing])
}
