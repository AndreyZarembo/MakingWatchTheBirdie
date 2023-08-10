//
//  ToolbarPattern.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import SwiftUI

struct SafeareaInsets: PreferenceKey {
    static var defaultValue = EdgeInsets.init()
    static func reduce(value: inout Value, nextValue: () -> Value) {
    }
}

struct ToolbarPattern: View {
    
    var pattern: ToolbarPatternStyle

    var toolbarSize: CGSize
    
    @State var insets: EdgeInsets = EdgeInsets()
    
    var angle: Angle = Angle.degrees(45)
    var overlaySize: CGSize {
        get {
            let fullHeight = (insets.top + toolbarSize.height + insets.bottom)
            let fullWidth = (insets.leading + toolbarSize.width + insets.trailing)
            
            let height: CGFloat =
            fullHeight * CoreGraphics.cos(angle.radians) +
            fullWidth * CoreGraphics.sin(angle.radians)
            
            let width: CGFloat =
            fullWidth * CoreGraphics.cos(angle.radians) +
            fullHeight * CoreGraphics.sin(angle.radians)
            
            return CGSize(width: width, height: height)
        }
    }
    
    var body: some View {
        
        if pattern != .notSet {
            ZStack {
                
                Color.clear
                    .ignoresSafeArea()
                    .frame(width: toolbarSize.width,
                           height: toolbarSize.height
                    )
                    .background {
                        GeometryReader { gr in
                            Color.clear
                                .preference(
                                    key: SafeareaInsets.self,
                                    value: gr.safeAreaInsets
                                )
                        }
                    }
                    .onPreferenceChange(SafeareaInsets.self) { insets in
                        self.insets = insets
                    }
                
                Image(pattern.rawValue)
                    .resizable(resizingMode: .tile)
                    .foregroundColor(Color.white)
                    .frame(
                        width: overlaySize.width,
                        height: overlaySize.height
                    )
                    .rotationEffect(angle, anchor: UnitPoint.center)

            }
            .mask {
                Color.white
                    .ignoresSafeArea()
                    .frame(width: toolbarSize.width,
                           height: toolbarSize.height)
            }
            .frame(width: toolbarSize.width, height: toolbarSize.height)

        }
    }
}

struct ToolbarPattern_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { gr in
            
            ZStack {
                
                ToolbarsBackgroundGradient(accessLevel: .kids)
                
                VStack {
                    Spacer()
                    ToolbarPattern(
                        pattern: .photos,
                        toolbarSize: CGSize(width: gr.size.width, height: 80),
                        angle: Angle(degrees: 45)
                    )
                }
                
                VStack {
                    ToolbarPattern(
                        pattern: .photos,
                        toolbarSize: CGSize(width: gr.size.width, height: 80),
                        angle: Angle(degrees: 45)
                    )
                    Spacer()
                }
            }
        }
    }
}
