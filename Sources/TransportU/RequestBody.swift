//
//  RequestBody.swift
//  TransportU
//
//  Created by Maxim Bazarov on 08.09.19.
//  MIT License
//  Copyright © 2019 Maksim Bazarov. All rights reserved.


import Foundation

public
protocol RequestBody {
    associatedtype Parameters

    var parameters: Parameters { get }
    var data: Data? { get }
}


// MARK: - URL Encoded Body

public
struct FormURLEncodedBody: RequestBody {

    public let parameters: [String: String]

    public var data: Data? {
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

    public init(parameters: [String: String]) {
        self.parameters = parameters
    }
}



// MARK: - EmptyBody
public struct EmptyBodyType: RequestBody {
    public let parameters = ""
    public var data: Data?
}


public let EmptyBody = EmptyBodyType()



// MARK: - TextBody

struct TextBody: RequestBody {
    let parameters: String
    let encoding: String.Encoding

    var data: Data? {
        return parameters.data(using: encoding)
    }
}

// MARK: - JSON Body
public struct JSONBody<T: Encodable>: RequestBody {

    public let parameters: T
    public let encoding: String.Encoding

    public var data: Data? {
        return try? JSONEncoder().encode(parameters)
    }
}

// MARK: - Multipart Body
@available(*, unavailable, message: "Wasn't implemented yet.")
public struct MultipartBody: RequestBody {

    public let parameters: String

    public var data: Data? {
        fatalError("MultipartBody encoding was not implemented")
    }
}

// MARK: - File Body
@available(*, unavailable, message: "Wasn't implemented yet.")
public struct FileBody: RequestBody {

    public let parameters: String

    public var data: Data? {
        fatalError("FileBody encoding was not implemented")
    }
}

