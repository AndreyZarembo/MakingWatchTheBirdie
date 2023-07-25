//
//  SideButtonsDimPreview.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.07.2023.
//

import SwiftUI
import Combine

class Dimmer: ObservableObject {
    
    @Published var dim: Bool = false
    var sub1: Cancellable?
    var sub2: Cancellable?
    
    func subscribe(_ subj: some Publisher<Void, Never>) {
        sub1 = subj.sink { [weak self] _ in
            withAnimation(.easeOut(duration: 0.25)) {
                self?.dim = true
            }
        }
        sub2 = subj
        .debounce(for: .seconds(1), scheduler: RunLoop.main)
        .sink { [weak self] _ in
            withAnimation(.easeIn(duration: 0.25)) {
                self?.dim = false
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct SideButtonsDimPreview: View {
    
    var didScroll = PassthroughSubject<Void,Never>()
    @ObservedObject var dimmer: Dimmer = Dimmer()
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                VStack {
                    ForEach(0..<100) { t in
                        HStack {
                            Spacer()
                            Text("Scroll me")
                                .font(.largeTitle)
                                .frame(height: 96)
                            Spacer()
                        }
                    }
                }
                .background(GeometryReader {
                    Color.clear.preference(
                        key: ViewOffsetKey.self,
                        value: $0.frame(in: .global).origin.y)
                })
                .onPreferenceChange(ViewOffsetKey.self) { yOffset in
                    didScroll.send(Void())
                }
            }
            
            SideButtonLayout(
                accessLevel: .kids,
                side: .left,
                dimmed: dimmer.dim,
                sideButtons: [
                    SideButton(icon: "Filters") {}
                ]
            )
        }
        .onAppear {
            dimmer.subscribe(didScroll)
        }
    }
    
}

struct SideButtonsDimPreview_Previews: PreviewProvider {
    static var previews: some View {
        SideButtonsDimPreview()
    }
}
