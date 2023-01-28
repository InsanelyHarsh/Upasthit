//
//  OnBoardingView.swift
//  Upasthit Student
//
//  Created by Harsh Yadav on 28/01/23.
//

import SwiftUI

struct OnBoardingView: View {
    @StateObject private var onBoardingManager:OnBoardingManager = OnBoardingManager()
    let action:()->Void
    var body: some View {
        VStack{
            if(onBoardingManager.items.count>0){
                TabView {
                    ForEach(onBoardingManager.items) { item in
                        OnBoardingCustomLayoutView(data: item)
                            .overlay(alignment: .bottom){
                                if(self.onBoardingManager.items.last! == item){
                                    Button {
                                        action()
                                    } label: {
                                        Text("Continue")
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .padding(.bottom,50)
                                }
                            }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                
                Spacer()
            }
            
        }
        .onAppear{
            self.onBoardingManager.load()
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView{ }
            .environmentObject(SessionManager())
    }
}
