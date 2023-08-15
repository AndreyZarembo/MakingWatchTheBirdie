//
//  LiveCoding.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 09.08.2023.
//

import SwiftUI

struct LiveCoding: View {
    @State var password: String = ""
    @State var showPass: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                if showPass {
                    TextField("Password", text: $password)
                }
                else {
                    SecureField("Password", text: $password)
                }
                
                Button { showPass.toggle() } label: {
                    if showPass {
                        Image (systemName: "eye.slash")
                            .foregroundColor(.black)
                    }
                    else {
                        Image (systemName: "eye")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .padding(12)
        .frame(maxWidth: 256)
        .background(Color.white)
        .cornerRadius (12)
        .shadow(color: .black.opacity(0.12), radius: 10)
    }
}

#Preview {
    LiveCoding()
}
