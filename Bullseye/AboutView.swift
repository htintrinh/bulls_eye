//
//  AboutView.swift
//  Bullseye
//
//  Created by trinh.tin on 2020/04/25.
//  Copyright © 2020 New Tetra. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let begie = Color.init(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    struct HeadlineTextStyle : ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(.custom("Arial Rounded MT Bold", size: 40))
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    var body: some View {
        Group {
            VStack{
                Text("😀This is my 1st tutorial app. yeah!").modifier(HeadlineTextStyle())
                Text("This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. This is very long demo text. ")
            }
            .navigationBarTitle("About")
            .background(begie)
        }.background(Image("Background"))
        
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
