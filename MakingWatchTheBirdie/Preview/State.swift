//
//  State.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 09.08.2023.
//

import SwiftUI

struct ShowPasswordButton: View {
    @Binding var showPassword: Bool
    var body: some View {
        Button {
            showPassword.toggle()
        } label: {
            Image(systemName: showPassword ? "eye" : "eye.slash")
        }
    }
}

#Preview("Constant") {
    return ShowPasswordButton(showPassword: .constant(false))
}

#Preview("Not working with Macro") {
    @State var showPassword: Bool = false
    return ShowPasswordButton(showPassword: $showPassword)
}

struct StaticState_Preview: PreviewProvider {
    @State static var showPassword: Bool = false
    static var previews: some View {
        ShowPasswordButton(showPassword: $showPassword)
            .previewDisplayName("Not working with PP")
    }
}

struct StaticStateWapper: View {
    @State var showPassword: Bool = false
    var body: some View {
        ShowPasswordButton(showPassword: $showPassword)
    }
}

#Preview("Working With Macro") {
    return StaticStateWapper()
}

struct StaticStateWapper_Preview: PreviewProvider {
    static var previews: some View {
        StaticStateWapper()
        .previewDisplayName("Working With PP")
    }
}
