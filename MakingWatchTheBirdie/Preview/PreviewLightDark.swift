//
//  PreviewLightDark.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 09.08.2023.
//

import Foundation
import SwiftUI

struct Light_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("Dark")
        .preferredColorScheme(.dark)
    }
}

#Preview("Light") {
    ViewForPreview()
    .preferredColorScheme(.light)
}
