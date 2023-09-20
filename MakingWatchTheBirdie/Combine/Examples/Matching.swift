//
//  Matching.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 15.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var matching: OperationInfoCollection = OperationInfoCollection(
        title: "Matching",
        operations: [
            
            OperationInfo(
                title: "Contains",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .blue, icon: .triangle),
                                .delay,
                                .item(color: .green, icon:  .star),
                            ])
                        ], equation: "a.contains( blue ▲ )",
                        output: .bool { inputs in
                            inputs["a"]!.contains( .item(color: .blue, icon: .triangle) )
                        }
                    ),
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .green, icon: .triangle),
                                .delay,
                                .item(color: .green, icon:  .star),
                            ])
                        ], equation: "b.contains( blue ▲ )",
                        output: .bool { inputs in
                            inputs["b"]!.contains( .item(color: .blue, icon: .triangle) )
                        }
                    ),
                    
                    OperationInfoExample(
                        inputs: [
                            Input(title: "c", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .green, icon: .triangle),
                                .delay,
                                .item(color: .green, icon:  .star),
                            ])
                        ], equation: "c.contains(where: any ▲ )",
                        output: .bool { inputs in
                            inputs["c"]!.contains { item in
                                item?.icon == .triangle
                            }
                        }
                    )
                ]),
            
            OperationInfo(
                title: "All Satisfy",
                examples: [
                    OperationInfoExample(
                        inputs: [
                            Input(title: "a", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .blue, icon: .triangle),
                                .delay,
                                .item(color: .green, icon:  .star),
                            ])
                        ], equation: "a.allSatisfy( ★ )",
                        output: .bool { inputs in
                            inputs["a"]!.allSatisfy { item in
                                item?.icon == .star
                            }
                        }
                    ),
                    OperationInfoExample(
                        inputs: [
                            Input(title: "b", items: [
                                .item(color: .red, icon: .star),
                                .item(color: .blue, icon: .star),
                                .delay,
                                .item(color: .green, icon:  .star),
                            ])
                        ], equation: "b.allSatisfy( ★ )",
                        output: .bool { inputs in
                            inputs["b"]!.allSatisfy { item in
                                item?.icon == .star
                            }
                        }
                    ),
                ]),
            
        ])
}

#Preview {
    CombineDemo(collections: [SwiftCombineDemo.matching])
}
