//
//  PublisherPreview.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 13.09.2023.
//

import SwiftUI

enum Icon: Equatable {
    case none
    case star
    case triangle
    case asterisk
    case number(value: Int)
    case letter(value: Character)
    case more
    
    var iconName: String {
        switch self {
        case .none: return ""
        case .star: return "star.fill"
        case .asterisk: return "staroflife.fill"
        case .triangle: return "triangle.fill"
        case .number: return ""
        case .letter: return ""
        case .more: return "ellipsis"
        }
    }
}

enum Item: Equatable {
    case delay
    case `nil`
    case error(color: Color)
    case item(color: Color, icon: Icon)
    case finish
    case array(items: ItemsArray)
    case json(jsonString: String)
}

class ItemsArray {
    let items: [Item]
    init(items: [Item]) {
        self.items = items
    }
}

struct PublisherPreview: View {
    
    var items: [Item] = [
        .json(jsonString: "A"),
        .item(color: .red, icon: .star),
        .nil,
        .item(color: .blue, icon: .asterisk),
        .delay,
        .item(color: .green, icon: .triangle),
        .error(color: .red),
//        .item(color: .cyan, icon: .letter(value: "A")),
        .item(color: .purple, icon: .number(value: 9)),
        .array(items: ItemsArray(items: [
            .item(color: .red, icon: .number(value: 4)),
            .item(color: .green, icon: .star),
            .item(color: .blue, icon: .none)
        ])),
        .finish
    ]
    
    var body: some View {
        
//        ScrollView([.horizontal]) {
            ZStack(alignment: .leading) {
                
                Color.black.frame(height: 2)
                
                HStack {
                    Spacer()
                    Image(systemName: "arrowtriangle.forward.fill")
                        .offset(x: 2, y: 0)
                }
                
                HStack {
                    ForEach(items.indices.reversed(), id: \.self) { index in
                        let item = items[index]
                        ItemPreview(item: item)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                
            }
            .padding(12)
            .frame(height: 54)
//        }
    }
}

#Preview {
    PublisherPreview()
}
