//
//  ToolbarElements.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import Foundation
import SwiftUI

enum ToolbarElements {
    
    case buttons(buttons: [ToolbarButton])
    case view(view: any View)
}
