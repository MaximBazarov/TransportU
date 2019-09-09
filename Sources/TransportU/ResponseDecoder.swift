//
//  ResponseDecoder.swift
//  TransportU
//
//  Created by Maxim Bazarov on 08.09.19.
//  MIT License
//  Copyright © 2019 Maksim Bazarov. All rights reserved.


import Foundation

enum ResponseDecoder<Value: Decodable> {
    case json(of: Value.Type)
    case custom(decode: (Data) throws -> Value)

    func decode(_ data: Data) throws -> Value {
        switch self {
        case .json(let valueType): return try JSONDecoder().decode(valueType, from: data)
        case .custom(let decode): return try decode(data)
        }
        
    }
}
