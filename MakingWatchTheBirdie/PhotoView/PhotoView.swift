//
//  PhotoView.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 27.09.2023.
//

import SwiftUI

struct ImageSizeKey: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {}
}

struct ViewportSizeKey: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {}
}

struct ZoomedImageSizeKey: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {}
}


struct PhotoView: View {
    
    @State var zoom: CGFloat = 0.25
    @State var gesture_zoom: CGFloat = 1.0
    @State var zoomedImageSize: CGSize = CGSize()
    @State var angle: Angle = Angle.degrees(30)
    @State var gesture_angle: Angle = Angle.degrees(0)
    
    var body: some View {
        
        GeometryReader { parentGR in
            
            ScrollView([.vertical, .horizontal]) {
                
                ZStack {
                    
                    Image("Sample 8")
                        .scaleEffect(zoom * gesture_zoom)
                        .rotationEffect(angle + gesture_angle)
                        .overlay {
                            GeometryReader { imageGR in
                                //
                                Color.clear
                                    .preference(
                                        key: ImageSizeKey.self,
                                        value: imageGR.size)
                                    .preference(
                                        key: ZoomedImageSizeKey.self,
                                        value: CGSize(
                                            width: imageGR.size.width * zoom * gesture_zoom,
                                            height: imageGR.size.height * zoom * gesture_zoom))
                                    .onPreferenceChange(ZoomedImageSizeKey.self,
                                                        perform: { value in
                                        zoomedImageSize = value
                                        print(value)
                                    })
                            }
                        }
                        .gesture(MagnificationGesture()
                            .onChanged {
                                gesture_zoom = $0
                            }
                            .onEnded { _ in
                                zoom = zoom * gesture_zoom
                                gesture_zoom = 1
                            }
                        )
                        .simultaneousGesture(RotationGesture()
                            .onChanged { gesture_angle = $0}
                            .onEnded { _ in
                                angle = angle + gesture_angle
                            }
                        )
                }
                .frame(width: zoomedImageSize.width, height: zoomedImageSize.height)
                .padding(EdgeInsets(
                    top: 96,
                    leading: 96,
                    bottom: 96,
                    trailing: 96))
                .onChange(of: zoom) { oldValue, newValue in
                    print("OLD", oldValue, newValue)
                }
            }
        }
    }
}

#Preview {
    PhotoView()
}
