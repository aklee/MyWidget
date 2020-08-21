//
//  LikeWidget.swift
//  LikeWidget
//
//  Created by ak on 2020/8/19.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    static var idx: Int = 0
    
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let title = "hello"
        let entry = SimpleEntry(date: Date(), title: title, idx: -1, configuration: configuration)
        completion(entry)
    }
    
    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        NSLog("timeline");
        
        //可以通过AppGroup，完成Widget和App交互
//        let ud = UserDefaults.init(suiteName: "group.getui.demo")!
//        let title = ud.value(forKey: "title") as? String ?? ""
        
        let currentDate = Date()
        let title = " \(configuration.name ?? "hi") 最喜欢你."
        for hourOffset in 1 ..< title.count {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, title: title, idx: hourOffset, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let title: String
    public let idx: Int
    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct LikeWidgetEntryView : View {
    var entry: Provider.Entry
    func displayTitle() -> String {
        let str = entry.title.count == 0 ? " " : entry.title;
        let idx = min(str.count - 1, entry.idx)
        NSLog("\(entry.title) \(String(str.prefix(idx)))")
        return String(str.prefix(idx))
    }
    
    var body: some View {
        NSLog("tick")
        return VStack() {
            Image(uiImage: #imageLiteral(resourceName: "loveletter"))
                    .resizable()
                    .frame(width: 38, height: 38, alignment: .center)
            
        Text("我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你我喜欢你")
            .lineLimit(1)
            .font(.some(.custom("", size: 2)))
            .foregroundColor(.red)
            .frame(maxWidth: .infinity)
            .frame(height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding(3)
        
//            Color.red
//                .frame(maxWidth: .infinity)
//                .frame(height: 2, alignment: .center)
//                .opacity(0.8)
//                .padding(3)
            
            Text(displayTitle())
                .foregroundColor(.red)
                .opacity(0.8)
        }
        .padding()

        
//        Text(entry.date, style: .time)
    }
}

@main
struct LikeWidget: Widget {
    private let kind: String = "LikeWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            LikeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct LikeWidget_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
