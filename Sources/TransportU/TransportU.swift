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
struct Transport<U: Request> {
    let baseURL: URL?
    let perform: (U) -> Promise<Response<U.ResultType>>
}
