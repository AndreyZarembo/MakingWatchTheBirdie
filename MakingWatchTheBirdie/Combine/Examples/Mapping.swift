//
//  Mapping.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 15.09.2023.
//

import Foundation
import Combine
import SwiftUI


extension SwiftCombineDemo {
    
    static var mapping: OperationInfoCollection = OperationInfoCollection(
        title: "Mapping",
        operations: [
            
            OperationInfo(
                title: "Map",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .blue, icon: .star),
                                .delay,
                                .item(color: .green, icon:  .star)
                            ])
                        ],
                        equation: "a.map( ★ → ▲ )",
                        output: .publisher { inputs in
                            inputs["a"]!.map { $0!.mapOperation() }
                        }
                    )
                ]),
            
            OperationInfo(
                title: "MapError",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .star),
                                .error(color: .red),
                                .delay,
                                .item(color: .green, icon:  .star)
                            ])
                        ],
                        equation: "a.mapError( red → green )",
                        output: .publisher { inputs in
                            inputs["a"]!
                            .mapError { error in
                                guard case let .error(color) = error, color == .red else { return error }
                                return DemoError.error(color: .green)    
                            }
                        }
                    )
                ]),
            
            OperationInfo(
                title: "ReplaceNil",
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
                        equation: "a.replaceNil(with: ★ )",
                        output: .publisher { inputs in
                            inputs["a"]!.replaceNil(with: Item.item(color: .orange, icon: .star))
                                .map { (r) -> Item? in r }
                        }
                    )
                ]),
            
            OperationInfo(
                title: "Scan",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 2)),
                                .item(color: .purple, icon: .star),
                                .item(color: .green, icon: .number(value: 3)),
                                .delay,
                                .item(color: .orange, icon: .number(value: 4)),
                            ])
                        ],
                        equation: "a.scan(.yellow) { repaint } ",
                        output: .publisher { inputs in
                            inputs["a"]!.scan(Item.item(color: .teal, icon: .number(value: 0))) { res, item in
                                guard case let .item(_, icon) = item, case let .item(res_color, _) = res else {
                                    return res
                                }
                                return Item.item(color: res_color, icon: icon)
                            }
                        }
                    )
                ]
            ),
            
            OperationInfo(
                title: "SetFailureType",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .error(color: .green)
                            ])
                        ],
                        equation: "a.catch { ... }.setFailureType(DemoError.self)",
                        output: .publisher { inputs in
                            inputs["a"]!.catch { _ in Just(Item.error(color: .red)) }
                            .setFailureType(to: DemoError.self)
                        }
                    )
                ]
            ),
            
            OperationInfo(
                title: "Map Keypath",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 2)),
                                .item(color: .purple, icon: .star),
                                .item(color: .green, icon: .number(value: 3)),
                            ])
                        ],
                        equation: "a.map(\\.color).map { .item($0...) }",
                        output: .publisher { inputs in
                            inputs["a"]!.map(\.?.color)
                            .compactMap { color in
                                guard let _color = color else { return nil }
                                return Item.item(color: _color, icon: .none)
                            }
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .number(value: 1)),
                                .item(color: .blue, icon: .number(value: 2)),
                                .item(color: .purple, icon: .star),
                                .item(color: .green, icon: .number(value: 3)),
                            ])
                        ],
                        equation: "b.map(\\.color, \\.icon).map { .item($0.0, $0.1) }",
                        output: .publisher { inputs in
                            inputs["b"]!.map(\.?.color, \.?.icon)
                            .compactMap { color, icon in
                                guard let _color = color, let _icon = icon else { return nil }
                                return Item.item(color: _color, icon: _icon)
                            }
                        }
                    )
                ]
            )
            
        ])
}

#Preview {
    CombineDemo(collections: [SwiftCombineDemo.mapping])
}
