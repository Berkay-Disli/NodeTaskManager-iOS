//
//  FileManager.swift
//  Abonesepeti
//
//  Created by Marjan on 9/21/1400 AP.
//

import Foundation

extension FileManager {
    static func getDirectoryURL(directory: FileManager.SearchPathDirectory) throws -> URL {
        guard let directoryURL = FileManager.default.urls(for: directory, in: .userDomainMask).first else {
            throw Errors.invalidDestination
        }
        return directoryURL
    }

    static func getFileName(from url: URL) -> NSString {
        let fileName = url.lastPathComponent
        return NSString(string: fileName)
    }

    static func getFileURL(fileName: String, in directory: FileManager.SearchPathDirectory) throws -> URL? {
        let directoryURL = try getDirectoryURL(directory: directory)
        let contents = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        for content in contents {
            if content.lastPathComponent == fileName {
                return content
            }
        }
        return nil
    }
}

extension FileManager {
    enum Errors: Error {
        case invalidDestination
    }
}

extension FileManager.Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidDestination:
            return "Hedef dosya yolu bulunamadı."
        }
    }
}
