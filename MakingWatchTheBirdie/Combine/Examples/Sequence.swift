//
//  Sequence.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 14.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var sequence: OperationInfoCollection = OperationInfoCollection(
        title: "Sequence",
        operations: [
            
            OperationInfo(
                title: "Drop",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .triangle),
                                .item(color: .red, icon: .triangle),
                                .delay,
                                .item(color: .blue, icon: .star),
                                .item(color: .green, icon:  .asterisk),
                            ])
                        ], equation: "a.drop(while: ▲)",
                        output: .publisher { inputs in
                            inputs["a"]!.drop(while: { $0!.icon == .triangle } )
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .red, icon: .triangle),
                                .delay,
                                .item(color: .blue, icon: .star),
                                .item(color: .green, icon:  .asterisk),
                            ])
                        ], equation: "b.drop(while: ▲)",
                        output: .publisher { inputs in
                            inputs["b"]!.drop(while: { $0!.icon == .triangle } )
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "c", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .blue, icon: .number(value: 7)),
                                .item(color: .green, icon:  .number(value: 9)),
                            ]),
                            Input(title: "d", items: [
                                .delay,
                                .delay,
                                .item(color: .orange, icon: .star),
                                .delay,
                                .delay,
                            ])
                        ], equation: "c.drop(untilOutputFrom: d)",
                        output: .publisher { inputs in
                            inputs["c"]!.drop(untilOutputFrom: inputs["d"]!)
                        }
                    )
                ]),
            
            
            OperationInfo(
                title: "Drop First",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .blue, icon: .number(value: 7)),
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "a.dropFirst()",
                        output: .publisher { inputs in
                            inputs["a"]!.dropFirst()
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 5)),
                                .delay,
                                .item(color: .blue, icon: .number(value: 7)),
                                .item(color: .green, icon:  .number(value: 9)),
                            ])
                        ], equation: "b.dropFirst(2)",
                        output: .publisher { inputs in
                            inputs["b"]!.dropFirst(2)
                        }
                    ),
                ]),
            
            
            
            OperationInfo(
                title: "Append",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .none),
                                .item(color: .orange, icon: .none),
                            ])
                        ], equation: "a.append(▲, ★, ✽)",
                        output: .publisher { inputs in
                            inputs["a"]!.append(
                                .item(color: .red, icon: .triangle),
                                .item(color: .blue, icon: .star),
                                .item(color: .green, icon: .asterisk)
                            )
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .none),
                                .item(color: .orange, icon: .none),
                                .finish,
                                .delay,
                                .delay
                            ]),
                            Input(title: "c", items: [
                                .item(color: .red, icon: .asterisk),
                                .delay,
                                .delay,
                                .item(color: .green, icon: .triangle),
                                .item(color: .blue, icon: .star),
                            ])
                        ], equation: "b.append(c)",
                        output: .publisher { inputs in
                            inputs["b"]!.append(inputs["c"]!)
                        }
                    ),
                    
                ]),
            
            OperationInfo(
                title: "Prepend",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .none),
                                .item(color: .orange, icon: .none),
                            ])
                        ], equation: "a.prepend(▲, ★, ✽)",
                        output: .publisher { inputs in
                            inputs["a"]!.prepend(
                                .item(color: .red, icon: .triangle),
                                .item(color: .blue, icon: .star),
                                .item(color: .green, icon: .asterisk)
                            )
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .delay,
                                .delay,
                                .delay,
                                .item(color: .red, icon: .none),
                                .item(color: .orange, icon: .none),
                            ]),
                            Input(title: "c", items: [
                                .item(color: .green, icon: .triangle),
                                .item(color: .blue, icon: .star),
                                .finish,
                                .delay,
                            ])
                        ], equation: "b.prepend(c)",
                        output: .publisher { inputs in
                            inputs["b"]!.prepend(inputs["c"]!)
                        }
                    ),
                    
                ]),
            
            OperationInfo(
                title: "Prefix",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .green, icon: .star),
                                .item(color: .blue, icon: .none),
                                .item(color: .orange, icon: .asterisk),
                                .item(color: .purple, icon: .triangle),
                            ])
                        ],
                        equation: "a.prefix(3)",
                        output: .publisher { inputs in
                            inputs["a"]!.prefix(3)
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .green, icon: .star),
                                .item(color: .blue, icon: .none),
                                .item(color: .orange, icon: .asterisk),
                                .item(color: .purple, icon: .triangle),
                            ]),
                            Input(title: "c", items: [
                                .delay,
                                .delay,
                                .item(color: .red, icon: .none),
                                .delay,
                            ]),
                        ],
                        equation: "b.prefix(untilOutputFrom: c)",
                        output: .publisher { inputs in
                            inputs["b"]!.prefix(untilOutputFrom: inputs["c"]!)
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "d", items: [
                                .item(color: .red, icon: .triangle),
                                .item(color: .green, icon: .triangle),
                                .item(color: .blue, icon: .triangle),
                                .item(color: .orange, icon: .asterisk),
                                .item(color: .purple, icon: .triangle),
                            ])
                        ],
                        equation: "d.prefix(while: ▲)",
                        output: .publisher { inputs in
                            inputs["d"]!.prefix { $0!.icon == .triangle }
                        }
                    ),
                    
                ]),
            
        ])
}

#Preview {
    CombineDemo(collections: [SwiftCombineDemo.sequence])
}
