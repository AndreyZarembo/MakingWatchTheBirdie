//
//  CroppedImageDebug.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 05.09.2023.
//

import Foundation
import SwiftUI

struct CroppedImageDebug: View {
    
    @State var zoom: CGFloat = 1.0
    @State var mode: ViewMode = .crop
    
    @State var id: UUID

    @State var imageURL: URL
    @State var originalURL: URL

    @State var angle: Angle
    @State var rotation: RotateLargeAnge
    @State var cropSize: CGSize
    @State var cropCenter: CGPoint
    
    @State var originalImageSize: CGSize
    
    @State var centerShift: CGPoint = CGPoint()
    
    var cropW: Binding<CGFloat> {
        return Binding {
            return cropSize.width
        } set: { val in
            cropSize = CGSize(width: val, height: cropSize.height)
        }
    }
    
    var cropH: Binding<CGFloat> {
        return Binding {
            return cropSize.height
        } set: { val in
            cropSize = CGSize(width: cropSize.width, height: val)
        }
    }
    
    var cropX: Binding<CGFloat> {
        return Binding {
            return cropCenter.x
        } set: { val in
            cropCenter = CGPoint(x: val, y: cropCenter.y)
        }
    }
    
    var cropY: Binding<CGFloat> {
        return Binding {
            return cropCenter.y
        } set: { val in
            cropCenter = CGPoint(x: cropCenter.x, y: val)
        }
    }
    
    var fAngle: Binding<CGFloat> {
        return Binding {
            return CGFloat(angle.radians)
        } set: { val in
            angle = Angle(radians: val)
        }
    }
    
    init() {
        let mediaRecord: MediaRecord = .cropTestMedia()
        
        _id = State(initialValue: mediaRecord.id)
        _imageURL = State(initialValue: mediaRecord.imageURL)
        _originalURL = State(initialValue: mediaRecord.originalURL)
        _angle = State(initialValue: Angle(radians: mediaRecord.cropAndRotateData.angle))
        _rotation = State(initialValue: mediaRecord.cropAndRotateData.largeAngle)
        _cropSize = State(initialValue: mediaRecord.cropAndRotateData.cropSize)
        _cropCenter = State(initialValue: mediaRecord.cropAndRotateData.cropCenter)
        _originalImageSize = State(initialValue: mediaRecord.originalImageSize)
    }
    
    var body: some View {
        ZStack {
            CroppedImageViewControllerRepresentable(
                id: id,
                imageURL: imageURL,
                originalURL: originalURL,
                angle: angle,
                rotation: rotation,
                cropSize: $cropSize,
                cropCenter: $cropCenter,
                originalImageSize: originalImageSize,
                
                mode: mode,
                zoom: $zoom,
                centerShift: $centerShift
            )
            .background(Color.black)
            
            VStack {

                HStack {
                    Text("a\(fAngle.wrappedValue.sh)").foregroundStyle(.green).background(.black)
                    Slider(value: fAngle, in: -CGFloat.pi/2...CGFloat.pi/2)
                }
                
                Spacer()
                Text("\(zoom)")
                .foregroundStyle(.green)
                .background(.black)
                .cornerRadius(4.0)
                
                Slider(value: $zoom, in: 0.1...10)
                
                HStack {
                    Button {
                        mode = .crop
                    } label: { Text("Crop") }
                    Button {
                        mode = .edit
                    } label: { Text("Edit") }
                    Button {
                        mode = .view
                    } label: { Text("View") }
                }
            }
            
        }
    }
}
