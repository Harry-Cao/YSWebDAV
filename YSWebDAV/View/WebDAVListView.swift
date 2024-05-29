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
    @State private var addItemViewPresenting = false

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
                            HStack(spacing: 8) {
                                Image(systemName: "link")
                                    .frame(width: 8, height: 8)
                                Text(item.host + item.path)
                                    .font(.caption)
                            }
                            .foregroundStyle(.gray)
                            HStack(spacing: 8) {
                                Image(systemName: "person")
                                    .frame(width: 8, height: 8)
                                Text(item.userName)
                                    .font(.caption)
                            }
                            .foregroundStyle(.gray)
                        }
                    }
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first else { return }
                    modelContext.delete(items[index])
                }
            }
            .navigationTitle("WebDAV List")
            .sheet(isPresented: $addItemViewPresenting, content: {
                AddWebDAVView()
            })
            .toolbar {
                Button {
                    addItemViewPresenting = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
