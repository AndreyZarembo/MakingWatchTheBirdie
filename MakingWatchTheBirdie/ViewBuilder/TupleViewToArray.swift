//
//  TupleViewToArray.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.08.2023.
//

import Foundation
import SwiftUI

extension TupleView {
    
    var getViews: [AnyView] {
        makeArray(from: value)
    }
    
    private struct GenericView {
        
        let body: Any
        var anyView: AnyView? {
            AnyView(_fromValue: body)
        }
    }
    
    private func makeArray<Tuple>(from tuple: Tuple) -> [AnyView] {
        
        func convert(child: Mirror.Child) -> AnyView? {
            withUnsafeBytes(of: child.value) { ptr -> AnyView? in
                let binded = ptr.bindMemory(to: GenericView.self)
                return binded.first?.anyView
            }
        }

        let tupleMirror = Mirror(reflecting: tuple)
        return tupleMirror.children.compactMap(convert)
    }
}

struct ArrayContainer: View {
    
    let content: [AnyView]
        
    init<Views>(@ViewBuilder content: @escaping () -> TupleView<Views>) {
        self.content = content().getViews
    }
    
    var body: some View {
        
        VStack {
            ForEach(content.indices, id: \.self) { index in
                content[index].frame(width: 128, height: 64)
                    .background(.white)
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black.opacity(0.05), lineWidth: 1)
                    }
                    .shadow(color: .black.opacity(0.1), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

#Preview {
    ArrayContainer() {
        Text("!")
        Text("?")
    }
}

