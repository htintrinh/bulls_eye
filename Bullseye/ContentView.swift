//
//  ContentView.swift
//  Bullseye
//
//  Created by trinh.tin on 2020/04/24.
//  Copyright © 2020 New Tetra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isAlertAvailable = false
    @State var slideValue = 0.0
    @State var currentTarget = Int.random(in: 1...100)
    @State var currentPoint = 0
    @State var roundNumber = 0
    @State var totalPoint = 0
    @State var feedbackTitle = ""
    
    struct LabelViewStyled: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.white)
                .font(.custom("Kannada Sangam MN-Bold", size: 24))
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ValueViewStyled: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.yellow)
                .font(.custom("Arial Rounded MT Bold", size: 24))
                .shadow(color: .black, radius: 5, x: 2, y: 2)
            
        }
    }
    
    struct ButtonStyled: ViewModifier {
        func body(content: Content) -> some View {
            content.background(Image("Button"), alignment: .center)
                .frame(width: 100, height: 50, alignment: .center)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            // target row
            HStack {
                Text("Slide close as posible to this number: ").modifier(LabelViewStyled())
                Text("\(self.currentTarget)").modifier(ValueViewStyled())
            }
            Spacer()
            // slide row
            Slider(value: self.$slideValue, in: 1...100)
            // button row
            HitMeButton()
            Spacer()
            // score row
            HStack() {
                
                Button(action: {self.resetRound()}){
                    Text("Start Over")
                    
                }
                    .modifier(ButtonStyled())
                Spacer()
                
                Text("Score").modifier(LabelViewStyled())
                Text("\(self.totalPoint)").modifier(ValueViewStyled())
                Spacer()
                Text("Round").modifier(LabelViewStyled())
                Text("\(self.roundNumber)").modifier(ValueViewStyled())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    Text("Info")
                }.modifier(ButtonStyled())
            }
        }.background(Image("Background"))
    }
    
    func updateFeedbackTitle() {
        if (self.currentPoint == 100) {
            self.feedbackTitle = "Perfect!"
        } else if (self.currentPoint > 80) {
            self.feedbackTitle = "Good"
        } else if (self.currentPoint > 50) {
            self.feedbackTitle = "Soso"
        } else {
            return self.feedbackTitle = "Not so good!"
        }
    }
    
    func HitMeButton() -> some View {
        return Button(
            action: {
                self.isAlertAvailable = true
                self.calculateCurrentPoint()
                self.updateFeedbackTitle()
        }) {
            Text(/*@START_MENU_TOKEN@*/"Hit me"/*@END_MENU_TOKEN@*/)
        }
        .alert(isPresented: $isAlertAvailable)
        {() -> Alert in
            return Alert (
                title: Text("\(self.feedbackTitle)"),
                message: Text("Your point is: \(self.currentPoint)"),
                dismissButton: .default(Text("Dismiss"), action: {
                    self.randomCurrentTarget()
                    self.incrementCurrentRound()
                    self.calculateTotalPoint()
                }))
        }
        .modifier(ButtonStyled())
    }
    
    func resetRound() {
        self.roundNumber = 0
        self.currentPoint = 0
        self.totalPoint = 0
        randomCurrentTarget()
    }
    
    func calculateCurrentPoint() {
        let roundedValue = Int(self.slideValue.rounded())
        self.currentPoint = 100 - abs(self.currentTarget - roundedValue)
    }
    
    func incrementCurrentRound() -> Void {
        self.roundNumber += 1
    }
    
    func calculateTotalPoint() {
        self.totalPoint += self.currentPoint
    }
    
    func randomCurrentTarget() -> Void {
        self.currentTarget = Int.random(in: 1...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
