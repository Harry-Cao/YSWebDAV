//
//  FilesViewModel.swift
//  YSWebDavPlayer
//
//  Created by HarryCao on 2024/5/25.
//

import Foundation

final class FilesViewModel: ObservableObject {
    let item: WebDAVItem
    private var client: WebDAVClient?
    @Published var files = [WebDAVFile]()
    @Published var searchText = ""

    init(item: WebDAVItem) {
        self.item = item
        self.client = WebDAVClient(baseURL: URL(string: item.baseUrl), username: item.userName, password: item.password)
        loadFiles()
    }

    var searchResult: [WebDAVFile] {
        if searchText.isEmpty {
            return files
        }
        return files.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
    }

    func loadFiles() {
        client?.listDirectory(at: item.path) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let files):
                    self.files = files
                case .failure(let error):
                    print("Failed to load files: \(error)")
                }
            }
        }
    }

    func getUrl(file: WebDAVFile) -> URL {
        return URL(string: "\(item.baseUrl)\(file.path)")!
    }

    func itemFromFolder(_ folder: WebDAVFile) -> WebDAVItem {
        return WebDAVItem(name: Tool.fileNameFromPath(folder.path),
                          userName: item.userName,
                          password: item.password,
                          baseUrl: item.baseUrl,
                          path: folder.path)
    }
}
