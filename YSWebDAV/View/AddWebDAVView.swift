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
    @State private var testSuccess: Bool?

    var body: some View {
        NavigationView {
            List {
                Section("Server") {
                    TextField("Name: WebDAV", text: $item.name)
                    TextField("Host e.g: `http://192.168.0.1:80`", text: $item.host)
                    TextField("Path e.g: /remote.php/dav/files/user/", text: $item.path)
                }
                Section("Credentials") {
                    TextField("Username", text: $item.userName)
                    SecureField("Password", text: $item.password)
                }
                Section("Preview") {
                    HStack {
                        indicatorColor
                            .frame(width: 8, height: 8)
                            .clipShape(.circle)
                        Text(previewString)
                    }
                    Button {
                        testItem()
                    } label: {
                        Text("Test")
                    }
                    .disabled(previewString.isEmpty)
                }
            }
            .navigationTitle("Add WebDAV")
            .toolbar {
                Button {
                    addItem()
                } label: {
                    Text("Save")
                }
            }
        }
    }

    private var indicatorColor: Color {
        guard let testSuccess else { return .gray }
        return testSuccess ? .green : .red
    }

    private var previewString: String {
        item.host + item.path
    }

    private var formattedItem: WebDAVItem? {
        guard let formattedItem = item.copy() as? WebDAVItem else { return nil }
        if !formattedItem.path.hasSuffix("/") {
            formattedItem.path += "/"
        }
        if formattedItem.name.isEmpty {
            formattedItem.name = Tool.fileNameFromPath(formattedItem.path)
        }
        return formattedItem
    }

    private func testItem() {
        testSuccess = nil
        WebDAVClient(baseURL: URL(string: item.host), username: item.userName, password: item.password).listDirectory(at: item.path) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.testSuccess = true
                case .failure:
                    self.testSuccess = false
                }
            }
        }
    }

    private func addItem() {
        guard let formattedItem else { return }
        modelContext.insert(formattedItem)
        dismiss()
    }
}
