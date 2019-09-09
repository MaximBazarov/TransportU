//
//  Response.swift
//  ChessGuru
//
//  Created by Maxim Bazarov on 08.09.19.
//  Copyright © 2019 Maksim Bazarov. All rights reserved.
//

import Foundation


/// Type erasure for `Response` type
protocol ResponseType {
    associatedtype ResultType: Decodable
}


/// Generic `Response`
enum Response<T: Decodable>: ResponseType {

    typealias ResultType = T

    /// Request succesfully returns data
    case success(ResultType)

    /// Transport threw an `Error`
    case transportError(Error)

    /// Request succeeded but data is empty
    case emptyData

    /// Request succeeded but data can't be decoded to `ResultType`
    case parsingError(Error)

    /// Request can't be handled properly
    case unhandled(Data?, URLResponse?, Error?)
}

