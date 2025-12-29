//
//  Header.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 29/12/25.
//

import SwiftUI

struct HeaderView: View {
    let title:String
    let description:String
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 40))
                Text(description)
                    .font(.title3)
                    .foregroundColor(.gray)
            }.offset(y:10)

        }.frame(maxWidth: .infinity, maxHeight: 140, alignment: .leading).padding(.horizontal, 30)
    }
}

#Preview {
    HeaderView(title:"DeepWork", description: "No tasks yet")
}
