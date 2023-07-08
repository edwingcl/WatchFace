//
//  ContentView.swift
//  WatchFace
//
//  Created by 颜小 on 08/07/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        VStack{
            WatchMain()
                .frame(width: 200, height: 200, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
