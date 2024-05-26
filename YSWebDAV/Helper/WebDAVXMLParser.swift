//
//  WebDAVXMLParser.swift
//  YSWebDavPlayer
//
//  Created by HarryCao on 2024/5/25.
//

import Foundation

class WebDAVXMLParser: NSObject, XMLParserDelegate {
    private let data: Data
    private let path: String
    private var files: [WebDAVFile] = []
    private var currentElement: String = ""
    private var currentFileName: String = ""
    private var currentFilePath: String = ""
    private var completion: ((Result<[WebDAVFile], Error>) -> Void)?

    init(data: Data, path: String) {
        self.data = data
        self.path = path
    }

    func parse(completion: @escaping (Result<[WebDAVFile], Error>) -> Void) {
        self.completion = completion
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        completion?(.success(files))
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        completion?(.failure(parseError))
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "d:href":
            currentFilePath = string
        case "d:displayname":
            currentFileName = string
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "d:response",
           currentFilePath != path {
            files.append(WebDAVFile(type: Tool.fileType(from: currentFilePath), name: Tool.fileNameFromPath(currentFilePath), path: currentFilePath))
            currentFileName = ""
            currentFilePath = ""
        }
    }
}

