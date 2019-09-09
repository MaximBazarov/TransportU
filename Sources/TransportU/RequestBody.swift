//
//  RequestBody.swift
//  ChessGuru
//
//  Created by Maxim Bazarov on 08.09.19.
//  Copyright © 2019 Maksim Bazarov. All rights reserved.
//

import Foundation


protocol RequestBody {
    associatedtype Parameters

    var parameters: Parameters { get }
    var data: Data? { get }
}


// MARK: - URL Encoded Body

struct FormURLEncodedBody: RequestBody {

    let parameters: [String: String]

    var data: Data? {
        let parts: [String] = self.parameters.compactMap { (key, value) in
            guard
                let key = key
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let value = value
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else { return nil }
            return "\(key)=\(value)"
        }

        return parts
            .joined(separator: "&")
            .data(using: .utf8, allowLossyConversion: true)
    }
}


// MARK: - TextBody

struct TextBody: RequestBody {

    let parameters: String
    let encoding: String.Encoding

    var data: Data? {
        return parameters.data(using: encoding)
    }
}

// MARK: - JSON Body

struct JSONBody<T: Encodable>: RequestBody {

    let parameters: T
    let encoding: String.Encoding

    var data: Data? {
        return try? JSONEncoder().encode(parameters)
    }
}

// MARK: - Multipart Body

struct MultipartBody: RequestBody {

    let parameters: String

    var data: Data? {
        fatalError("MultipartBody encoding was not implemented")
    }
}

// MARK: - File Body
struct FileBody: RequestBody {

    let parameters: String

    var data: Data? {
        fatalError("FileBody encoding was not implemented")
    }
}

