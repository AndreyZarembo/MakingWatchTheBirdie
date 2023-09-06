//
//  ViewBuilderExample.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 27.08.2023.
//

import SwiftUI

struct ViewBuilderExample: View {
    var body: Text
    
    init() {
        self.body = Text("Test")
    }
}

struct ViewBuilderExample2: View {
    
    var body: some View {
//            return viewBuiderBody
            return handMadeBody
    }
    
    @ViewBuilder var viewBuiderBody: some View {
        Text("Test")
        Text("Test2")
    }
    
    var handMadeBody: some View {
        return AnyView(TupleView<(Text, Text)>(
            (
                Text("Test"),
                Text("Test2")
            )
        ))
    }

}

#Preview {
    ViewBuilderExample()
}

#Preview {
    ViewBuilderExample2()
}
