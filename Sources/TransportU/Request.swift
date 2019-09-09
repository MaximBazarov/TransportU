//
//  Request.swift
//  ChessGuru
//
//  Created by Maxim Bazarov on 08.09.19.
//  Copyright © 2019 Maksim Bazarov. All rights reserved.
//

import Foundation


protocol Request {

    /// Request
    associatedtype Body: RequestBody
    var endpoint: String { get }
    var body: Body { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }

    /// Result
    associatedtype ResultType: Decodable
    var decoder: ResponseDecoder<ResultType> { get }
}

// MARK: - JSON Decoder
/// Default decoder for responses is JSON
extension Request {
    var decoder: ResponseDecoder<ResultType> {
        return ResponseDecoder.json(of: ResultType.self)
    }
}
