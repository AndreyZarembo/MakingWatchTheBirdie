//
//  CombineDemo.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 13.09.2023.
//

import SwiftUI

struct CombineDemo: View {
    
    @State var collections: [OperationInfoCollection] = SwiftCombineDemo.operations
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(collections.indices, id: \.self) { collectionIndex in
                        let collection = collections[collectionIndex]
                        Text(collection.title)
                            .font(.title)
                            .padding(EdgeInsets(
                                top: 0,
                                leading: 12,
                                bottom: 0,
                                trailing: 0
                            ))
                        
                        ForEach(collection.operations.indices, id: \.self) { operationIndex in
                            
                            let operation = collection.operations[operationIndex]
                            NavigationLink(value: operation) {
                                Text("• " + operation.title)
                                    .font(.title2)
                                    .padding(EdgeInsets(
                                        top: 0,
                                        leading: 15,
                                        bottom: 0,
                                        trailing: 0
                                    ))
                            }
                        }
                        
                        Spacer().frame(height: 24)
                    }
                }
                .padding(12)
            }
            .navigationDestination(for: OperationInfo.self) { operationInfo in
                OperationInfoDemo(info: operationInfo)
            }
        }
    }
}

#Preview {
    CombineDemo()
}
