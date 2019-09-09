//
//  Request.swift
//  TransportU
//
//  Created by Maxim Bazarov on 08.09.19.
//  MIT License
//  Copyright © 2019 Maksim Bazarov. All rights reserved.

import Foundation

public
protocol Request {

    associatedtype Body: RequestBody
    associatedtype ResultType: Decodable

    /// Request
    var endpoint: String { get }
    var body: Body { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }

    /// Response
    var decoder: ResponseDecoder<ResultType> { get }
}

// MARK: - JSON Decoder
/// Default decoder for responses is JSON
public extension Request {
    var decoder: ResponseDecoder<ResultType> {
        return ResponseDecoder.json(of: ResultType.self)
    }
    
}

public struct EmptyResponse: Codable {

}

public extension Request where ResultType == EmptyResponse{
    var decoder: ResponseDecoder<ResultType> {
        return ResponseDecoder.custom {  _ in
            return EmptyResponse()
        }
    }
}
