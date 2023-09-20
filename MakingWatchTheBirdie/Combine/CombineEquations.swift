//
//  CombineEquations.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 13.09.2023.
//

import Foundation
import SwiftUI

extension Item {
    
    func mapOperation() -> Item {
        
        let ACode = Int(("A" as UnicodeScalar).value)
        
        switch self {
        case .delay: return .delay
        case .error(let color): return .error(color: color)
        case .finish: return .finish
        case .nil: return .nil
        case .array(let items): return .array(items: items)
        case .item(let color, let icon):
            switch icon {
            case .none: return .item(color: color, icon: .star)
            case .star: return .item(color: color, icon: .triangle)
            case .triangle: return .item(color: color, icon: .asterisk)
            case .asterisk: return .item(color: color, icon: .star)
            case .number(let value): return .item(color: color, icon: .letter(value: Character(UnicodeScalar(value + ACode)!)))
            case .letter(let value): return .item(color: color, icon: .number(value: Int(value.asciiValue ?? UInt8(ACode)) - ACode))
            case .more: return .item(color: color, icon: .more)
            }
        case .json(let jsonString): return .json(jsonString: jsonString)
        }
    }
    
    func lower(than b: Item) -> Bool {
        let a = self
        if case let .item(_, a_icon) = a, case let .item(_, b_icon) = b {
            if case let .number(a_value) = a_icon, case let .number(b_value) = b_icon {
                print("a/b", a_value, b_value)
                return a_value < b_value
            }
        }
        return false
    }
    
    var color: Color? {
        switch self {
        case .delay: return nil
        case .error(let color): return color
        case .finish: return nil
        case .nil: return nil
        case .item(let color, _): return color
        case .array: return nil
        case .json: return nil
        }
    }
    
    var icon: Icon? {
        switch self {
        case .delay: return nil
        case .error: return nil
        case .finish: return nil
        case .nil: return nil
        case .item(_, let icon): return icon
        case .array: return nil
        case .json: return nil
        }
    }
}

extension Item: Comparable {
    
    static func < (lhs: Item, rhs: Item) -> Bool {
        lhs.lower(than: rhs)
    }
    
}

extension Item {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        
        switch (lhs, rhs) {
        case (.delay, .delay): return true
        case (.error(let a_icon), .error(let b_icon)): return a_icon == b_icon
        case (.finish, .finish): return true
        case (.nil, .nil): return true
        case (.item(let a_color, let a_icon), .item(let b_color, let b_icon)): return a_color == b_color && a_icon == b_icon
        case (.array(let a_items), .array(let b_items)): return a_items == b_items
        default:
            return false
        }
    }
}

extension ItemsArray: Equatable {
    
    static func == (lhs: ItemsArray, rhs: ItemsArray) -> Bool {
        return lhs.items == rhs.items
    }
}

extension Item: Codable {
    
    enum KeyPath: CodingKey {
        case type
        case color
        case items
        case icon
        case iconValue
    }
    
    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: KeyPath.self)
        switch self {
        case .nil: try c.encode("nil", forKey: .type)
        case .delay: try c.encode("delay", forKey: .type)
        case .finish: try c.encode("finish", forKey: .type)
        case .error(let color):
            try c.encode("error", forKey: .type)
            try c.encode(color, forKey: .color)
        case .array(let items):
            try c.encode("array", forKey: .type)
            try c.encode(items.items, forKey: .items)
        case .item(let color, let icon):
            try c.encode("item", forKey: .type)
            try c.encode(color, forKey: .color)
            switch icon {
            case .asterisk: try c.encode("asterisk", forKey: .icon)
            case .none: try c.encode("none", forKey: .icon)
            case .more: try c.encode("more", forKey: .icon)
            case .star: try c.encode("star", forKey: .icon)
            case .triangle: try c.encode("triangle", forKey: .icon)
            case .letter(let value):
                try c.encode("letter", forKey: .icon)
                try c.encode("\(value)", forKey: .iconValue)
            case .number(let value):
                try c.encode("number", forKey: .icon)
                try c.encode(value, forKey: .iconValue)
            }
        case .json:
            break
        }
    }
    
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: KeyPath.self)
        switch try c.decode(String.self, forKey: .type) {
        case "nil": self = .nil
        case "delay": self = .delay
        case "finish": self = .finish
        case "error":
            let color = try c.decode(Color.self, forKey: .color)
            self = .error(color: color)
        case "items":
            let items = try c.decode([Item].self, forKey: .items)
            self = .array(items: ItemsArray(items: items))
        case "item":
            let color = try c.decode(Color.self, forKey: .color)
            let icon: Icon
            switch try c.decode(String.self, forKey: .icon) {
            case "asterisk": icon = .asterisk
            case "star": icon = .star
            case "triangle": icon = .triangle
            case "more": icon = .triangle
            case "number":
                let number: Int = try c.decode(Int.self, forKey: .iconValue)
                icon = .number(value: number)
            case "letter":
                let letterStr = try c.decode(String.self, forKey: .iconValue)
                let letter = Character(letterStr)
                icon = .letter(value: letter)
            default:
                icon = .none
            }
            self = .item(color: color, icon: icon)
            
        default: self = .nil
        }
    }
}

extension Color: Codable {
    
    public func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        switch self {
        case .red: try c.encode("red")
        case .blue: try c.encode("blue")
        case .orange: try c.encode("orange")
        case .green: try c.encode("green")
        case .teal: try c.encode("teal")
        case .purple: try c.encode("purple")
        case .black: try c.encode("black")
        case .cyan: try c.encode("cyan")
        case .yellow: try c.encode("yellow")
        case .mint: try c.encode("mint")
        case .indigo: try c.encode("indigo")
        case .pink: try c.encode("pink")
        case .brown: try c.encode("brown")
        case .white: try c.encode("white")
        case .gray: try c.encode("gray")
        default: try c.encode("black")
        }
    }
    
    public init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        switch try c.decode(String.self) {
        case "red": self = .red
        case "blue": self = .blue
        case "orange": self = .orange
        case "green": self = .green
        case "teal": self = .teal
        case "purple": self = .purple
        case "black": self = .black
        case "cyan": self = .cyan
        case "yellow": self = .yellow
        case "mint": self = .mint
        case "indigo": self = .indigo
        case "pink": self = .pink
        case "brown": self = .brown
        case "white": self = .white
        case "gray": self = .gray
        default: self = .black
        }
    }
}
