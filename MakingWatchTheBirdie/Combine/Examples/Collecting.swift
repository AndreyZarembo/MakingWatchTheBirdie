//
//  Collecting.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 15.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var collecting: OperationInfoCollection = OperationInfoCollection(
        title: "Collecting & Republishing",
        operations: [
            
            OperationInfo(
                title: "Combine Latest AB",
                examples: [
                    
                    OperationInfoExample.init(
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
                        equation: "a.combineLatest(b) { [a,b] }",
                        output: .publisher { inputs in
                            inputs["a"]!.combineLatest(inputs["b"]!) { a, b in
                                .array(items: ItemsArray(items: [a, b].compactMap { $0 }))
                            }
                        }),
                    
                    OperationInfoExample.init(
                        inputs: [
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                    .item(color: .green, icon: .triangle),
                                ]),
                            Input(
                                title: "d",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                    .item(color: .cyan, icon: .number(value: 3)),
                                ])
                        ],
                        equation: "c.combineLatest(d).map( (,) → [,] )",
                        output: .publisher { inputs in
                            inputs["c"]!.combineLatest(inputs["d"]!)
                                .map { tuple in
                                    
                                    let arr: [Item?] = Mirror(reflecting: tuple).children.map { $0.value as? Item }
                                    return .array(items: ItemsArray(items: arr.compactMap { $0 }))
                                }
                        })
                    
                ]),
            
            OperationInfo(
                title: "Combine Latest ABC",
                examples: [
                    
                    OperationInfoExample.init(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                ]),
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                ]),
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .green, icon: .letter(value: "A")),
                                    .item(color: .cyan, icon: .letter(value: "B")),
                                ])
                        ],
                        equation: "a.combineLatest(b,c) { [a,b,c] }",
                        output: .publisher { inputs in
                            inputs["a"]!.combineLatest(inputs["b"]!, inputs["c"]!) { a, b, c in
                                    .array(items: ItemsArray(items: [a, b, c].compactMap { $0 }))
                            }
                        }),
                    
                    
                    OperationInfoExample.init(
                        inputs: [
                            Input(
                                title: "d",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                ]),
                            Input(
                                title: "e",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                ]),
                            Input(
                                title: "f",
                                items: [
                                    .item(color: .green, icon: .letter(value: "A")),
                                    .item(color: .cyan, icon: .letter(value: "B")),
                                ])
                        ],
                        equation: "d.combineLatest(e,f).map( (,) → [,] )",
                        output: .publisher { inputs in
                            inputs["d"]!.combineLatest(inputs["e"]!, inputs["f"]!)
                                .map { tuple in
                                    
                                    let arr: [Item?] = Mirror(reflecting: tuple).children.map { $0.value as? Item }
                                    return .array(items: ItemsArray(items: arr.compactMap { $0 }))
                                }
                        })
                ]),
            
            OperationInfo(
                title: "Combine Latest ABCD",
                examples: [
                    
                    OperationInfoExample.init(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                ]),
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                ]),
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .green, icon: .letter(value: "A")),
                                    .item(color: .cyan, icon: .letter(value: "B")),
                                ]),
                            Input(
                                title: "d",
                                items: [
                                    .item(color: .yellow, icon: .none),
                                    .item(color: .teal, icon: .none),
                                ])
                        ],
                        equation: "a.combineLatest(b,c,d) { [a,b,c,d] }",
                        output: .publisher { inputs in
                            inputs["a"]!.combineLatest(inputs["b"]!, inputs["c"]!, inputs["d"]!) { a, b, c, d in
                                    .array(items: ItemsArray(items: [a, b, c, d].compactMap { $0 }))
                            }
                        }),
                    
                    OperationInfoExample.init(
                        inputs: [
                            Input(
                                title: "e",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                ]),
                            Input(
                                title: "f",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                ]),
                            Input(
                                title: "g",
                                items: [
                                    .item(color: .green, icon: .letter(value: "A")),
                                    .item(color: .cyan, icon: .letter(value: "B")),
                                ]),
                            Input(
                                title: "h",
                                items: [
                                    .item(color: .yellow, icon: .none),
                                    .item(color: .teal, icon: .none),
                                ])
                        ],
                        equation: "e.combineLatest(f,g,h).map( (,) → [,] )",
                        output: .publisher { inputs in
                            inputs["e"]!.combineLatest(inputs["f"]!, inputs["g"]!, inputs["h"]!)
                                .map { tuple in
                                    let arr: [Item?] = Mirror(reflecting: tuple).children.map { $0.value as? Item }
                                    return .array(items: ItemsArray(items: arr.compactMap { $0 }))
                                }
                        }),
                ]),
            
            OperationInfo(
                title: "Merge",
                examples: [
                    
                    OperationInfoExample.init(
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
                        equation: "a.merge(b)",
                        output: .publisher { inputs in
                            inputs["a"]!.merge(with: inputs["b"]!)
                        }),
                    
                    OperationInfoExample.init(
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
                                ]),
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .green, icon: .letter(value: "A")),
                                    .item(color: .cyan, icon: .letter(value: "B")),
                                ])
                        ],
                        equation: "a.merge(b, c)",
                        output: .publisher { inputs in
                            inputs["a"]!.merge(with: inputs["b"]!, inputs["c"]!)
                        }),
                ]),
            
            OperationInfo(
                title: "Zip AB",
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
                        equation: "a.zip(b).map( (,) → [,] )",
                        output: .publisher { inputs in
                            
                            inputs["a"]!.zip(inputs["b"]!)
                                .map { tuple in
                                    let arr: [Item?] = Mirror(reflecting: tuple).children.map { $0.value as? Item }
                                    return .array(items: ItemsArray(items: arr.compactMap { $0 }))
                                }
                        }),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                    .item(color: .green, icon: .triangle),
                                ]),
                            Input(
                                title: "d",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                    .item(color: .cyan, icon: .number(value: 3)),
                                ])
                        ],
                        equation: "c.zip(d) { [c,d] }",
                        output: .publisher { inputs in
                            
                            inputs["c"]!.zip(inputs["d"]!) { c, d in
                                .array(items: ItemsArray(items: [c, d].compactMap { $0 }))
                            }
                        })
                ]),
            
            OperationInfo(
                title: "Zip ABC",
                examples: [
                    
                    OperationInfoExample.init(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                ]),
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                ]),
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .green, icon: .letter(value: "A")),
                                    .item(color: .cyan, icon: .letter(value: "B")),
                                ])
                        ],
                        equation: "a.zip(b,c) { [a,b,c] }",
                        output: .publisher { inputs in
                            inputs["a"]!.zip(inputs["b"]!, inputs["c"]!) { a, b, c in
                                .array(items: ItemsArray(items: [a, b, c].compactMap { $0 }))
                            }
                        }),
                    
                    
                    OperationInfoExample.init(
                        inputs: [
                            Input(
                                title: "d",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                ]),
                            Input(
                                title: "e",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                ]),
                            Input(
                                title: "f",
                                items: [
                                    .item(color: .green, icon: .letter(value: "A")),
                                    .item(color: .cyan, icon: .letter(value: "B")),
                                ])
                        ],
                        equation: "d.zip(e,f).map( (,) → [,] )",
                        output: .publisher { inputs in
                            inputs["d"]!.zip(inputs["e"]!, inputs["f"]!)
                            .map { tuple in
                                    
                                let arr: [Item?] = Mirror(reflecting: tuple).children.map { $0.value as? Item }
                                return .array(items: ItemsArray(items: arr.compactMap { $0 }))
                            }
                        })
                ]),
            
            OperationInfo(
                title: "Zip ABCD",
                examples: [
                    
                    OperationInfoExample.init(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                ]),
                            Input(
                                title: "b",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                ]),
                            Input(
                                title: "c",
                                items: [
                                    .item(color: .green, icon: .letter(value: "A")),
                                    .item(color: .cyan, icon: .letter(value: "B")),
                                ]),
                            Input(
                                title: "d",
                                items: [
                                    .item(color: .yellow, icon: .none),
                                    .item(color: .teal, icon: .none),
                                ])
                        ],
                        equation: "a.zip(b,c,d) { [a,b,c,d] }",
                        output: .publisher { inputs in
                            inputs["a"]!.zip(inputs["b"]!, inputs["c"]!, inputs["d"]!) { a, b, c, d in
                                .array(items: ItemsArray(items: [a, b, c, d].compactMap { $0 }))
                              }
                        }),
                    
                    OperationInfoExample.init(
                        inputs: [
                            Input(
                                title: "e",
                                items: [
                                    .item(color: .red, icon: .star),
                                    .item(color: .blue, icon: .asterisk),
                                ]),
                            Input(
                                title: "f",
                                items: [
                                    .item(color: .orange, icon: .number(value: 1)),
                                    .item(color: .purple, icon: .number(value: 2)),
                                ]),
                            Input(
                                title: "g",
                                items: [
                                    .item(color: .green, icon: .letter(value: "A")),
                                    .item(color: .cyan, icon: .letter(value: "B")),
                                ]),
                            Input(
                                title: "h",
                                items: [
                                    .item(color: .yellow, icon: .none),
                                    .item(color: .teal, icon: .none),
                                ])
                        ],
                        equation: "e.zip(f,g,h).map( (,) → [,] )",
                        output: .publisher { inputs in
                            inputs["e"]!.zip(inputs["f"]!, inputs["g"]!, inputs["h"]!)
                            .map { tuple in
                                let arr: [Item?] = Mirror(reflecting: tuple).children.map { $0.value as? Item }
                                return .array(items: ItemsArray(items: arr.compactMap { $0 }))
                            }
                        }),
                ]),
        ])
}

#Preview {
    CombineDemo(collections: [SwiftCombineDemo.collecting])
}

