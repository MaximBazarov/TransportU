//
//  FakeTransportU.swift
//  PromiseU
//
//  Created by Maxim Bazarov on 09.09.19.
//

import Foundation
import TransportU
import PromiseU


/// Returns `Transport<R: Request>` which will return provided data
/// - Parameter request: request type
/// - Parameter response: data that will be returned
func fakeTransport<R: Request>(for request: R.Type, response: Data) -> Transport<R> {
    return Transport<R>(baseURL: nil) { request in
        return Promise<Response<R.ResultType>> { resolve in
            // Trying to parse data
            do {
                let result = try request.decoder.decode(response)
                resolve(.success(result))
            } catch {
                resolve(.parsingError(error))
            }

        }
    }
}
