//
//  ContentView.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 29/12/25.
//

import SwiftUI

struct TaskView: View {
    @State var input = ""
    @FocusState var isFocused:Bool
    var inputText:String{
        isFocused ? "What do you want to acomplish?" : "Add a new task"
    }
    var body: some View {
        VStack {
                HeaderView(title: "DeepWork", description: "No tasks yet")
            VStack{
                ZStack(alignment: .leading){
                    Rectangle().cornerRadius(16).frame(maxWidth: .infinity, maxHeight: 60).padding(.horizontal, 20).foregroundColor(.white)
                    if input.isEmpty{
                        HStack(spacing: 8) {
                            if !isFocused{
                                Image(systemName: "plus")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 30)
                            }
                            Text(inputText)
                                .foregroundColor(.gray)
                                .offset(x: isFocused ? 25 : -20)
                                
                        }.padding(.horizontal, 10 )
                    }
                    TextField("", text: $input)
                        .padding()
                        .padding(.horizontal, 20)
                        .focused($isFocused)
                }
                    
                
                
            }.frame(maxWidth: .infinity,maxHeight: 100).background(Color.black)
            VStack{}
            Spacer()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#Preview {
    TaskView()
}
