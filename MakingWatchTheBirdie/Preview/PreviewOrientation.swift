//
//  PreviewOrientation.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 09.08.2023.
//

import SwiftUI

struct Orientation_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
            .previewDisplayName("Horizontal LL")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

#Preview("Horizontal LR", traits: .landscapeRight) {
    ViewForPreview()
}
