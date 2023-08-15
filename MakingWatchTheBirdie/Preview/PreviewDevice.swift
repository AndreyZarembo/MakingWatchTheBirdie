//
//  PreviewDevice.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 09.08.2023.
//

import Foundation
import SwiftUI

struct iPhoneSE_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPhone SE")
        .previewDevice("iPhone SE (3rd generation)")
    }
}

struct iPhone14_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPhone 14")
        .previewDevice("iPhone 14")
    }
}

struct iPhone14Plus_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPhone 14 Plus")
        .previewDevice("iPhone 14 Plus")
    }
}

struct iPhone14Pro_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPhone 14 Pro")
        .previewDevice("iPhone 14 Pro")
    }
}

struct iPhone14ProMax_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPhone 14 Pro Max")
        .previewDevice("iPhone 14 Pro Max")
    }
}

struct iPadMini_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPad mini")
        .previewDevice("iPad mini (6th generation)")
    }
}

struct iPad_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPad")
        .previewDevice("iPad (10th generation)")
    }
}

struct iPadAir_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPad Air")
        .previewDevice("iPad Air (5th generation)")
    }
}

struct iPadPro11_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPad Pro 11")
        .previewDevice("iPad Pro (11-inch) (4th generation)")
    }
}

struct iPadPro12_Preview: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
        .previewDisplayName("iPad Pro 12.9")
        .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
