//
//  ContentView.swift
//  WidgetDemo
//
//  Created by ak on 2020/8/19.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
        Text("Hello, world!").padding().onTapGesture(count: 1, perform: {
            NSLog("tap")
            let ud = UserDefaults.init(suiteName: "group.getui.demo")!
            ud.setValue("xxx", forKey: "title")
//            WidgetCenter.shared.reloadAllTimelines()
            WidgetCenter.shared.reloadTimelines(ofKind: "LikeWidget")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
