//
//  ViewArrayContainer.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.08.2023.
//

import SwiftUI

protocol ArrayView: View {
    var asAny: AnyView { get }
}
extension ArrayView {
    public var asAny: AnyView { AnyView(self) }
}

extension Spacer: ArrayView {}
extension Text: ArrayView {}
extension Button: ArrayView {}
extension Image: ArrayView {}

struct ViewArrayContainer: View {
    
    let content: [any ArrayView]
    
    init(content: [any ArrayView]) {
        self.content = content.sorted(by: { a, b in
            "\(type(of: a))" > ("\(type(of: b))")
        })
    }
    
    var body: some View {
        ForEach(content.indices, id: \.self) { index in
            Group {
                switch content[index] {
                case let spacer as Spacer:
                    spacer.frame(height: 64)
                case let text as Text:
                    text.font(.title)
                case _ as Image:
                    EmptyView()
                default:
                    content[index].asAny
                }
            }
            .border(index == 0 ? .red : .clear, width: 2)
        }
    }
}

#Preview {
    ViewArrayContainer(content: [
        Text("!"),
        Spacer(),
        Text("?"),
        Image("Filters"),
        Button("10") {}
    ])
}
