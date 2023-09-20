//
//  Coding.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 15.09.2023.
//

import Foundation
import Combine
import SwiftUI

extension SwiftCombineDemo {
    
    static var coding: OperationInfoCollection = OperationInfoCollection(
        title: "Coding",
        operations: [
            
            OperationInfo(
                title: "Encoding",
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
                        equation: "a.encode(encoder: JSONEncoder())",
                        output: .stringResult { inputs in
                            
                            inputs["a"]!
                            .encode(encoder: JSONEncoder())
                            .mapError({ codeErrod in
                                return DemoError.error(color: .black)
                            })
                            .map { o in
                                String(data: o, encoding: .utf8) ?? ""
                            }
                            .collect()
                            .map { arr in
                                arr.joined(separator: "\n")
                            }
                        }),
                ]),
            
            OperationInfo(
                title: "Decoding",
                examples: [
                    
                    OperationInfoExample(
                        inputs: [
                            Input(
                                title: "a",
                                items: [
                                    .json(jsonString: """
{"color":"red","type":"item","icon":"star"}
"""),
                                    .json(jsonString: """
{"icon":"asterisk","color":"blue","type":"item"}
"""),
                                    .json(jsonString: """
{"color":"green","type":"item","icon":"triangle"}
"""),
                                ])
                        ],
                        equation: "a.decode(type: Item.self, decoder: JSONDecoder())",
                        output: .publisher { inputs in
                            
                            inputs["a"]!
                            .map { jsonItem in
                                guard case let .json(jsonString) = jsonItem else { return nil }
                                return jsonString.data(using: .utf8)
                            }
                            .compactMap { $0 }
                            .decode(type: Item.self, decoder: JSONDecoder())
                            .map { item -> Item? in item }
                            .mapError({ codeErrod in
                                return DemoError.error(color: .black)
                            })
                        }),
                ]),
        ])
}

#Preview {
    CombineDemo(collections: [SwiftCombineDemo.coding])
}
