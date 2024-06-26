//
//  YSWebDAVApp.swift
//  YSWebDAV
//
//  Created by HarryCao on 2024/5/26.
//

import SwiftUI
import SwiftData

@main
struct YSWebDAVApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WebDAVItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            WebDAVListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
