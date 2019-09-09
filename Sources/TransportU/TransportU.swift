//
//  TransportU.swift
//  TransportU
//
//  Created by Maxim Bazarov on 08.09.19.
//  MIT License
//  Copyright © 2019 Maksim Bazarov. All rights reserved.


import Foundation
import PromiseU


// MARK: - Transport<U>

/**
 Transport for performing a `Request<T>`
 */
public struct Transport<U: Request> {
    public let baseURL: URL?
    public let perform: (U) -> Promise<Response<U.ResultType>>

    public init(baseURL: URL? = nil, perform: @escaping (U) -> Promise<Response<U.ResultType>>) {
        self.baseURL = baseURL
        self.perform = perform
    }
}
