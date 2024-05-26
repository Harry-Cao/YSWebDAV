//
//  AddWebDAVView.swift
//  YSWebDavPlayer
//
//  Created by Harry Cao on 12/3/23.
//

import SwiftUI

struct AddWebDAVView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var item = WebDAVItem()

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                TextField(
                    "name",
                    text: $item.name
                )
                TextField(
                    "base url",
                    text: $item.baseUrl
                )
                TextField(
                    "path",
                    text: $item.path
                )
                TextField(
                    "username",
                    text: $item.userName
                )
                TextField(
                    "password",
                    text: $item.password
                )
                Button(action: {
                    addItem()
                    dismiss()
                }, label: {
                    Text("save")
                })
            }
            .padding()
            .navigationTitle("Add WebDAV")
        }
    }

    private func addItem() {
        modelContext.insert(item)
    }
}
