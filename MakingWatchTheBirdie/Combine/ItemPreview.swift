//
//  ItemPreview.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 14.09.2023.
//

import SwiftUI

struct ItemPreview: View {
    
    @State var item: Item
    var body: some View {
        switch item {
        case .finish:
            Image(systemName: "flag.checkered")
                .resizable()
                .frame(width: 20, height: 20)
                .offset(x: 0, y: -12)
                .foregroundColor(.black)
//                .background(.white)
        case .delay:
            Color.clear.frame(width: 32, height: 32)
            
        case .nil:
            ZStack {
                Color.gray.frame(width: 32, height: 32).cornerRadius(16)
                Text("nil")
                    .font(.title2)
                    .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
            }
        case .error(let color):
            ZStack {
                color.frame(width: 32, height: 32).cornerRadius(16)
                Image(systemName: "exclamationmark.circle")
                .resizable()
                .frame(width: 26, height: 26)
                .foregroundColor(.white)
                
            }
        case .item(let color, let icon):
            ZStack {
                color.frame(width: 32, height: 32).cornerRadius(16)
                if case let .number(value) = icon {
                    Text("\(value)")
                        .font(.headline)
                        .foregroundStyle(.white)
                } else if case let .letter(value) = icon {
                    Text(String([value]))
                        .font(.headline)
                        .foregroundStyle(.white)
                } else if icon != .none {
                    Image(systemName: icon.iconName)
                        .frame(width: 16, height: 16)
                        .foregroundColor(.white)
                }
                
            }
        case .array(let itemArray):
            let items = itemArray.items
            ZStack {
                ForEach(items.indices.prefix(3), id: \.self) { itemIndex in
                    Group {
                        if itemIndex == 2, items.count > 3 {
                            ItemPreview(item: .item(color: .gray, icon: .more))
                        }
                        else {
                            ItemPreview(item: items[itemIndex])
                        }
                    }
                    .offset(x: -14 * CGFloat(abs(itemIndex-1)), y: 11.0 * CGFloat(itemIndex-1) )
                }
            }
            .frame(width: 54)
        case .json:
            ZStack {
                Color.black.opacity(0.7).frame(width: 32, height: 32).cornerRadius(16)
                Image(systemName: "list.clipboard")
                    .frame(width: 16, height: 16)
                    .foregroundColor(.white)
            }
            .frame(width: 32)
        }
    }
}

#Preview("item") {
    ItemPreview(item: .item(color: .red, icon: .number(value: 4)))
}

#Preview("json") {
    ItemPreview(item: .json(jsonString: "--"))
}

#Preview("finish") {
    ItemPreview(item: .finish)
}

#Preview("nil") {
    ItemPreview(item: .nil)
}

#Preview("Error") {
    ItemPreview(item: .error(color: .blue))
}

#Preview("array") {
    ItemPreview(item: .array(items: ItemsArray(items: [
        .item(color: .red, icon: .number(value: 4)),
        .item(color: .green, icon: .star),
        .item(color: .blue, icon: .none),
        .item(color: .blue, icon: .none)
    ])))
}
