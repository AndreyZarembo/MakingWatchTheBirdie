//
//  ViewForPreview.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 09.08.2023.
//

import SwiftUI

struct ViewForPreview: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PreviewProviderMethod_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
            .previewDisplayName("Preview Provider")
    }
}

#Preview("Preview Macro") {
    ViewForPreview()
}

























