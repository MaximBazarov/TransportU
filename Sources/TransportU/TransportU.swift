//
//  TransportU.swift
//  ChessGuru
//

import Foundation
import PromiseU


// MARK: - Transport<U>

/**
 Transport for performing a `Request<T>`
 */
struct Transport<U: Request> {
    let baseURL: URL?
    let perform: (U) -> Promise<Response<U.ResultType>>
}
