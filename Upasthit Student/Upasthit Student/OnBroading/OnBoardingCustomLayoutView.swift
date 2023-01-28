//
//  OnBoardingCustomLayoutView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct OnBoardingCustomLayoutView: View {
    let data:OnBoardingItem
    var body: some View {
        VStack{
            Text("\(data.title)")
                .bold()
                .font(.system(.title, design: .monospaced))
            
            Text(data.emoji)
                .font(.system(size: 90))
                
            Text("\(data.content)")
                .padding()
                .font(.system(.title3, design: .monospaced))
            
            Spacer()
        }
        .padding(.top,50)
        .multilineTextAlignment(.center)
    }
}

struct OnBoardingCustomLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingCustomLayoutView(data: .init(emoji: "🤝", title: "Joint The Team", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut")
        )
    }
}
