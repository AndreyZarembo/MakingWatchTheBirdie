//
//  Toolbars.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 26.07.2023.
//

import SwiftUI

enum ToolbarLocation {
    case top
    case bottom
}

struct ToolbarFrameKey: PreferenceKey {
    static var defaultValue = CGRect.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {}
}

struct Toolbars<Content: View>: View {
    
    var location: ToolbarLocation
    var accessLevel: AccessLevel
    var pattern: ToolbarPatternStyle = .notSet
    var parentGR: GeometryProxy
    var elements: () -> Content
    
    init(
        location: ToolbarLocation,
        accessLevel: AccessLevel,
        pattern: ToolbarPatternStyle,
        parentGR: GeometryProxy,
        elements: @escaping () -> Content
    ) {
        self.location = location
        self.accessLevel = accessLevel
        self.pattern = pattern
        self.parentGR = parentGR
        self.elements = elements
    }
    
    @State private var toolbarFrame: CGRect = CGRect()
    
    func GradientMask(_ parentGR: GeometryProxy) -> Path {
        
        var shape = Rectangle()
        .path(in: CGRect(
            x:       0,
            y:      -parentGR.safeAreaInsets.top,
            width:   parentGR.size.width,
            height:  parentGR.size.height +
                     parentGR.safeAreaInsets.bottom +
                     parentGR.safeAreaInsets.top
        ))
        if location == .top {
            shape.addPath(Rectangle()
                .path(in: CGRect(
                    x: 0,
                    y: toolbarFrame.size.height,
                    width: parentGR.size.width,
                    height: parentGR.size.height - toolbarFrame.size.height + parentGR.safeAreaInsets.bottom
                )))

        }
        else {
            shape.addPath(Rectangle()
                .path(in: CGRect(
                    x: 0,
                    y: -parentGR.safeAreaInsets.top,
                    width: parentGR.size.width,
                    height: parentGR.size.height - toolbarFrame.size.height + parentGR.safeAreaInsets.top
                )))
        }
        return shape
    }
    
    var body: some View {
        
        elements()
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        .frame(
            minWidth: parentGR.size.width,
            minHeight: 72
        )
        .background(GeometryReader {
            Color.clear.preference(
                key: ToolbarFrameKey.self,
                value: $0.frame(in: .global))
        })
        .onPreferenceChange(ToolbarFrameKey.self) {
            toolbarFrame = $0
        }
        .background(alignment: location == .top ? .top : .bottom) {
            
            ToolbarsBackgroundGradient(accessLevel: accessLevel)
            .frame(width: parentGR.size.width, height: parentGR.size.height)
            .clipShape(GradientMask(parentGR), style: FillStyle(eoFill: true))
            .contentShape(GradientMask(parentGR), eoFill: true)
            .overlay(alignment: location == .top ? .top : .bottom) {
                ToolbarBorderGradient(location: location, accessLevel: accessLevel, width: parentGR.size.width)
                .offset(
                    x: 0,
                    y: location == .top ? toolbarFrame.size.height-2 : -toolbarFrame.size.height+2)
            }
            .overlay(alignment: location == .top ? .top : .bottom) {
                ToolbarPattern(pattern: pattern, toolbarSize: toolbarFrame.size)
                .opacity(accessLevel == .kids ? 0.1 : 0.15)
            }
        }
    }
}

struct TopBottomToolbardPreview: View {
    
    var accessLevel: AccessLevel
    var pattern: ToolbarPatternStyle
    
    @State var topToolbar: CGSize = CGSize()
    @State var bottomToolbar: CGSize = CGSize()
    
    var body: some View {
        
        GeometryReader { parentGR in
            
            VStack(spacing: 0) {
                
                Toolbars(
                    location: .top,
                    accessLevel: accessLevel,
                    pattern: pattern,
                    parentGR: parentGR
                ) {
                    ToolbarButtons([
                        ToolbarButton(accessLevel: accessLevel,icon: "SwapCamera", action: {}),
                        ToolbarButton(accessLevel: accessLevel,icon: "SwapCamera", action: {})
                    ])
                }
                
                Color.clear
                    .border(Color.blue, width: 8)
                    .zIndex(1)
                
                Toolbars(
                    location: .bottom,
                    accessLevel: accessLevel,
                    pattern: pattern,
                    parentGR: parentGR
                ) {
                    VStack {
                        ToolbarButton(accessLevel: accessLevel,icon: "SwapCamera", action: {})
                        ToolbarButton(accessLevel: accessLevel,icon: "SwapCamera", action: {})
                        ToolbarButton(accessLevel: accessLevel,icon: "SwapCamera", action: {})
                    }
                }
            }
        }
    }
}

struct Toolbars_Previews: PreviewProvider {
    static var previews: some View {
        
        TopBottomToolbardPreview(
            accessLevel: .kids,
            pattern: .gallery
        )
        .previewDisplayName("Kids Gallery")
        
        TopBottomToolbardPreview(
            accessLevel: .parent,
            pattern: .cases
        )
        .previewDisplayName("Parent Cases")
        
        TopBottomToolbardPreview(
            accessLevel: .kids,
            pattern: .photos
        )
        .previewDisplayName("Kids Photos")
        
        TopBottomToolbardPreview(
            accessLevel: .parent,
            pattern: .questions
        )
        .previewDisplayName("Parent Questions")
        
        TopBottomToolbardPreview(
            accessLevel: .kids,
            pattern: .scissors
        )
        .previewDisplayName("Kids Scissors")
        
        TopBottomToolbardPreview(
            accessLevel: .parent,
            pattern: .stars
        )
        .previewDisplayName("Parent Stars")
        
        TopBottomToolbardPreview(
            accessLevel: .kids,
            pattern: .notSet
        )
        .previewDisplayName("Kids Blank")
        
        TopBottomToolbardPreview(
            accessLevel: .parent,
            pattern: .notSet
        )
        .previewDisplayName("Parent Blank")
    }
}
