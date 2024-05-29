//
//  WebDAVListView.swift
//  YSWebDavPlayer
//
//  Created by Harry Cao on 12/3/23.
//

import SwiftUI
import SwiftData

struct WebDAVListView: View {
    @Query private var items: [WebDAVItem]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        FilesView(viewModel: FilesViewModel(item: item))
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.name)
                                .font(.system(.title3, weight: .medium))
                            Text("📃: \(item.host + item.path)")
                                .font(.caption)
                            Text("👨🏻: \(item.userName)")
                                .font(.caption)
                        }
                    }
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first else { return }
                    modelContext.delete(items[index])
                }
            }
            .navigationTitle("WebDAV List")
            .toolbar {
                NavigationLink {
                    AddWebDAVView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
