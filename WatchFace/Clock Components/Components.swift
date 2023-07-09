//
//  Components.swift
//  WatchFace
//
//  Created by 颜小 on 08/07/2023.
//

import SwiftUI

struct Arc: Shape {
    var startAngle: Angle = .radians(0)
    var endAngle: Angle = .radians(Double.pi * 2)
    var clockWise: Bool = true
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width/2, rect.height/2)
        
        path.addArc(center:  center, radius: radius , startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        
        return path
    }
}

struct Circle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        
        return path
    }
}

struct Hand: Shape {
    var offSet: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: rect.origin.x, y: rect.origin.y + offSet), size: CGSize(width: rect.width, height: rect.height/2 - offSet)), cornerSize: CGSize(width: rect.width/2, height: rect.width/2))
        
        return path
    }
}

struct Tick: Shape {
    var isLong: Bool = false
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x:rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x:rect.midX, y: rect.minY + 7 + (isLong ? 7 : 1) ))
        
        return path
    }
}

struct Ticks: View {
    var body: some View {
        ZStack {
            ForEach(0..<60) { position in
                Tick(isLong: position % 5 == 0 )
                    .stroke(lineWidth: 2)
                    .rotationEffect(.radians(Double.pi*2 / 60 * Double(position)))
            }
        }
    }
}

struct Numbers: View {
    var body: some View {
        ZStack{
            ForEach(1..<13) { hour in
                Number(hour: hour)
            }
        }
    }
}

struct Number: View {
    var hour: Int
    var body: some View {
        VStack {
            Text("\(hour)")
                .font(.system(size: 35, weight: .thin, design: .default))
                .rotationEffect(.radians(-(Double.pi*2 / 12 * Double(hour))))
            
            Spacer()
            
        }.padding()
        .rotationEffect(.radians((Double.pi*2 / 12 * Double(hour))))
    }
}
