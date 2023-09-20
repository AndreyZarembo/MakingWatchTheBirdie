//
//  OperationDemo.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 13.09.2023.
//

import SwiftUI
import Combine

enum DemoResult {
    case none
    case string(value: String)
    case int(value: Int)
    case bool(value: Bool)
    case sequence(items: [Item])
    case single(item: Item)
}

typealias InputsType = [String: PassthroughSubject<Item?, DemoError>]

enum OutputType {
    case strict(output: DemoResult)
    case publisher(operation: (_ inputs: InputsType) -> any Publisher<Item?, DemoError>)
    case stringResult(operation: (_ inputs: InputsType) -> any Publisher<String, DemoError>)
    case int(operation: (_ inputs: InputsType) -> any Publisher<Int, DemoError>)
    case bool(operation: (_ inputs: InputsType) -> any Publisher<Bool, DemoError>)
    case singleItem(operation: (_ inputs: InputsType) -> any Publisher<Item?, DemoError>)
}

struct Input {
    let title: String
    let items: [Item]
    
    init(title: String, items: [Item]) {
        self.title = title
        
        if items.contains(.finish) {
            
            self.items = items
        }
        else {
            self.items = items + [.finish]
        }
    }
}

struct OperationDemo: View {
    
    @State var inputs: [Input]
    @State var equation: String
    @State var output: OutputType
    @State var rawOutput: DemoResult = .none
    
    @State var cancellable: [AnyCancellable] = []
    
    func performOperation(_ operationClosure: (_ streams: InputsType) -> Void) {
        
        let max_input_steps = inputs.reduce(0) { partialResult, input in
            return max(partialResult, input.items.count)
        }

        let streams: InputsType = inputs.reduce([:]) { result, input in
            var nextResult = result
            nextResult[input.title] = PassthroughSubject<Item?, DemoError>()
            return nextResult
        }
        operationClosure(streams)
        
        let timer = Timer.publish(every: 0.01, on: RunLoop.main, in: .default)
        let connect = timer.connect()
            
        var itemIndex = 0
        timer.sink { dt in
            
//            print("tick", itemIndex, dt.timeIntervalSince1970)
            for inputIndex in 0..<inputs.count {
                
                let input = inputs[inputIndex]
                guard input.items.count > itemIndex else { continue }
                
                switch input.items[itemIndex] {
                case .item:
                    streams[input.title]!.send(input.items[itemIndex])
                case .nil:
                    streams[input.title]!.send(nil)
                case .delay:
                    continue
                case .finish:
                    streams[input.title]!.send(completion: .finished)
                case .error(let color):
                    streams[input.title]!.send(completion: .failure(DemoError.error(color: color)))
                case .array:
                    streams[input.title]!.send(input.items[itemIndex])
                case .json:
                    streams[input.title]!.send(input.items[itemIndex])
                }
            }
            
            itemIndex += 1
            if itemIndex >= max_input_steps {
                connect.cancel()
                for inputIndex in 0..<inputs.count {
                    let input = inputs[inputIndex]
                    streams[input.title]!.send(completion: .finished)
                }
            }
        }.store(in: &cancellable)
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                ForEach(inputs.indices, id: \.self) { inputId in
                    let input = inputs[inputId]
                    Text(input.title)
                        .font(.title3)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: -24, trailing: 0))
                    PublisherPreview(items: input.items)
                }
                
                Operation(equation: equation)
                
                switch rawOutput {
                case .none:
                    EmptyView()
                case .string(let value):
                    Text("\(value)")
                        .font(.title2)
                        .padding(12)
                case .int(let value):
                    Text("\(value)")
                        .font(.title2)
                        .padding(12)
                case .sequence(let items):
                    PublisherPreview(items: items)
                case .single(let item):
                    ItemPreview(item: item)
                case .bool(let value):
                    Text(value ? "True" : "False")
                        .font(.title2)
                        .padding(12)
                }
                
                Spacer()
            }
        }
        .onAppear {
            
            switch output {
            case .strict(let output):
                rawOutput = output
                
            case .publisher(let operation):
                performOperation { streams in

                    operation(streams)
                        .eraseToAnyPublisher()
                        .replaceNil(with: Item.nil)
                        .catch({ (error) -> Just<Item> in
                            guard case let .error(color) = error else {
                                return Just(Item.error(color: .orange))
                            }
                            return Just(Item.error(color: color))
                        })
                        .collect()
                        .sink { result in
                            rawOutput = DemoResult.sequence(items: result)
                        }
                        .store(in: &cancellable)                    
                }
                
            case .stringResult(let operation):
                performOperation { streams in
                
                    operation(streams)
                        .eraseToAnyPublisher()
                        .replaceError(with: "")
                        .sink { value in
                            rawOutput = DemoResult.string(value: value)
                        }
                        .store(in: &cancellable)
                }
            
            case .bool(let operation):
                performOperation { streams in
                
                    operation(streams)
                        .eraseToAnyPublisher()
                        .replaceError(with: false)
                        .sink { value in
                            rawOutput = DemoResult.bool(value: value)
                        }
                        .store(in: &cancellable)
                }
            
            case .int(let operation):
                performOperation { streams in
                
                    operation(streams)
                        .eraseToAnyPublisher()
                        .replaceError(with: 0)
                        .sink { value in
                            rawOutput = DemoResult.int(value: value)
                        }
                        .store(in: &cancellable)
                }
                
            default:
                break
                
            }
            
        }
    }
}

#Preview("Strict") {
    OperationDemo(
        inputs: [
            Input(title: "a", items: [
                .item(color: .red, icon: .none)
            ])
        ],
        equation: ".map(a)",
        output: .strict(output: .sequence(items: [
            .item(color: .red, icon: .star)
        ]))
    )
}

#Preview("Publisher") {
    OperationDemo(
        inputs: [
            Input(title: "a", items: [
                .item(color: .red, icon: .star),
                .item(color: .green, icon: .star)
            ])
        ],
        equation: "",
        output: .publisher(operation: { inputs in
            return inputs["a"]!.collect(.byTime(RunLoop.main, .milliseconds(22)) )
                .map { .array(items: ItemsArray(items: $0.compactMap { $0 })) }
        })
    )
}
