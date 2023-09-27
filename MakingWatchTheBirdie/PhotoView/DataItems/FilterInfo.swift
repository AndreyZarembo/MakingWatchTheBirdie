//
//  FilterInfo.swift
//  iOSWatchTheBirdie
//
//  Created by 18457250 on 08.09.2020.
//  Copyright © 2020 a.zarembo. All rights reserved.
//

import Foundation
import UIKit

enum FilterInfoParameter: Codable {
    
    case bool(value: Bool)
    case string(value: String)
    case int(value: Int)
    case float(value: Float)
}

struct FilterInfo: Codable {
    let filterId: String
    let parameters: [String: FilterInfoParameter]
}
