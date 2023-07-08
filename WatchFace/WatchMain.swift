//
//  WatchMain.swift
//  WatchFace
//
//  Created by 颜小 on 08/07/2023.
//

import SwiftUI

struct WatchMain: View {
    @State var date: Date = Date()
    
    //Counting current time by setting timer: 1 second
    func startCounting() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.date = Date()
            
//             withAnimation(.linear) {
//                 self.date = Date()
//             }
        }
    }
    
    var body: some View {
        @State var monthString = Date().getMonthString()
        @State var dayString = Date().getDayString()
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        var minuteAngle: Double = 0
        var hourAngle: Double = 0
        var secondAngle: Double = 0
        
        //The moving between each minute to next minutes, hours & second hand ticks..
        if let hour =  dateComponents.hour,
            let minute = dateComponents.minute,
            let second = dateComponents.second {
            
            let radianInOneHour = 2 * Double.pi / 12
            let radianInOneMinute = 2 * Double.pi / 60
            
            minuteAngle = Double(minute) * radianInOneMinute
            
            let actualHour = Double(hour) + (Double(minute)/60)
            hourAngle = actualHour * radianInOneHour
            secondAngle = Double(second) * radianInOneMinute
        }
        return ZStack{
            VStack{
                Text("Edwin")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary.opacity(0.6))
                
                Spacer()
                
                //seconds showing in digital way
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [3]))
                    .foregroundColor(.primary.opacity(0.3))
                    .frame(width: 40, height: 40, alignment: .center)
                    .overlay(
                        Text("\(date.formatted(.dateTime.second(.twoDigits)))")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary.opacity(0.7))
                    )
            }.padding(.vertical, 80)
            
            HStack{
                //Time showing in digital way
                Text("\(Date.now.formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .padding(.leading, 5)
                
                Spacer()
                
                //Day & month + weekday
                ZStack{
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [3]))
                        .foregroundColor(.primary.opacity(0.3))
                        .frame(width: 70, height: 70, alignment: .center)
                        .overlay(
                            VStack{
                                HStack{
                                    Spacer()
                                    
                                    Text("\(monthString)" + " " + "\(dayString)")
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        .foregroundColor(.primary.opacity(0.75))
                                }
                                
                                HStack{
                                    Spacer()
                                    
                                    Text("\(date.formatted(.dateTime.weekday()))")
                                        .font(.system(size: 13, weight: .bold, design: .rounded))
                                        .foregroundColor(.red.opacity(0.75))
                                }
                            }.padding(.trailing)
                        )
                }
            }.padding(.horizontal, 60)
            
            //Border of the clock in circle
            Arc()
                .stroke(lineWidth: 2)

            Ticks() //Hours & minutes ticks
            Numbers() //1...12
            Circle() //Overlay circle shape of the hour, minutes & second hand needle
                .fill()
                .frame(width: 15, height: 15, alignment: .center)
            
            //Hour hand
            Hand(offSet: 60)
                .fill()
                .frame(width: 4, alignment: .center)
                .rotationEffect(.radians(hourAngle))

            //Minute hand
            Hand(offSet: 10)
                .fill()
                .frame(width: 3, alignment: .center)
                .rotationEffect(.radians(minuteAngle))
            
            //Second hand
            Hand(offSet: 7)
                .fill()
                .foregroundColor(.red)
                .frame(width: 2, alignment: .center)
                .rotationEffect(.radians(secondAngle))
            
            Circle()
                .fill()
                .foregroundColor(.red)
                .frame(width: 7, height: 7, alignment: .center)
        }.frame(width: 300, height: 300, alignment: .center)
        .onAppear(perform: startCounting)
    }
}

extension Date {
     func getMonthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        
        let month = dateFormatter.string(from: Date())
         return month.capitalized
    }
    
    func getDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        let day = dateFormatter.string(from: Date())
        
        return day
    }
}

struct WatchMain_Previews: PreviewProvider {
    static var previews: some View {
        WatchMain()
    }
}
