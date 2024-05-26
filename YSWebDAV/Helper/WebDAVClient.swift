//
//  WebDAVClient.swift
//  YSWebDavPlayer
//
//  Created by HarryCao on 2024/5/25.
//

import Foundation

class WebDAVClient {
    private let baseURL: URL?
    private let username: String
    private let password: String

    init(baseURL: URL?, username: String, password: String) {
        self.baseURL = baseURL
        self.username = username
        self.password = password
    }

    func listDirectory(at path: String, completion: @escaping (Result<[WebDAVFile], Error>) -> Void) {
        guard let url = URL(string: path, relativeTo: baseURL) else {
            completion(.failure(WebDAVError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PROPFIND"
        request.setValue("1", forHTTPHeaderField: "Depth")

        let authString = "\(username):\(password)"
        if let authData = authString.data(using: .utf8) {
            let authValue = "Basic \(authData.base64EncodedString())"
            request.setValue(authValue, forHTTPHeaderField: "Authorization")
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(WebDAVError.noData))
                return
            }

            // 解析XML数据
            let parser = WebDAVXMLParser(data: data, path: path)
            parser.parse { result in
                completion(result)
            }
        }

        task.resume()
    }
}

enum WebDAVError: Error {
    case invalidURL
    case noData
}

