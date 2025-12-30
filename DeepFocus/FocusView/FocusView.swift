//
//  FocusView.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 29/12/25.
//

import SwiftUI

struct FocusView: View {
    var body: some View {
        VStack{
            HeaderView(title: "Pomodoro", description: "Configure your session")
            VStack{
                Spacer()
                VStack{
                    FocusSlider(title: "Study Time", icon: Image(systemName: "brain"), from: 10.00, to: 90.00)
                    FocusSlider(title: "Study Time", icon: Image(systemName: "brain"), from: 5.00, to:30.00)
                }.frame(maxWidth: .infinity, maxHeight: 300)
                    .background(.white)
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                
                Button{
                    
                }label:{
                    HStack{
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                        Text("Start Session")
                            .foregroundColor(.white)
                    }
                }.frame(maxWidth: .infinity, maxHeight: 70)
                    .background(.blue)
                    .cornerRadius(16)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.backgroundTask)
                
        }
    }
}


struct FocusSlider: View {
    let title:String
    let icon:Image
    let from:Double
    let to:Double
    @State var count:Double = 10.00
    var body: some View {
        VStack{
            HStack{
                HStack{
                    icon.bold().foregroundColor(.blue)
                    Text(title)
                }
                Spacer()
                Text("\(Int(count.rounded())) min").foregroundColor(.blue).bold()
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, 60)
                .padding(.vertical, 10)
            
            Slider(value:$count , in:from...to){
                
            }.padding(.horizontal, 50)
            
        }.frame(maxWidth: .infinity, maxHeight: 100)
    }
}
#Preview {
    FocusView()
}
