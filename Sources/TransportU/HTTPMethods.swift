//
//  HTTPMethods.swift
//  ChessGuru
//
//  Created by Maxim Bazarov on 08.09.19.
//  Copyright © 2019 Maksim Bazarov. All rights reserved.
//

import Foundation

enum HTTPMethod {

    case get
    case head

    case post
    case put
    case patch

    case delete

    case trace
    case option


    case custom(String)

    var code: String {
        switch self {

        case .get: return "GET"
        case .head: return "HEAD"

        case .post: return "POST"
        case .put: return "PUT"
        case .patch: return "PATCH"

        case .delete: return "DELETE"

        case .trace: return "TRACE"
        case .option: return "OPTION"

        case .custom(let code): return code
        }
    }

}
