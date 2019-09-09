//
//  URLSession+Transport.swift
//  TransportU
//
//  Created by Maxim Bazarov on 08.09.19.
//  MIT License
//  Copyright © 2019 Maksim Bazarov. All rights reserved.


import Foundation
import PromiseU

// MARK: - URLSession based transport

extension URLSession {


    /// Returns `Transport<R: Request>`
    func transport<R: Request>(for baseURL: URL, requestType: R.Type) -> Transport<R> {
        return Transport<R>(baseURL: baseURL) { request in
            return Promise<Response<R.ResultType>> { resolve in

                let url = baseURL.appendingPathComponent(request.endpoint)
                var urlRequest = URLRequest(url: url)

                urlRequest.allHTTPHeaderFields = request.headers
                urlRequest.httpMethod = request.method.code

                if let httpBody = request.body.data {
                    urlRequest.httpBody = httpBody
                }

                let task = self.dataTask(with: urlRequest, completionHandler:  { (data, response, error) in
                    if let error = error {
                        resolve(Response<R.ResultType>
                            .transportError(error)
                        )
                    }

                    guard let data = data else {
                        resolve(.emptyData)
                        return
                    }

                    // Trying to parse data
                    do {
                        let result = try request.decoder.decode(data)
                        resolve(.success(result))
                    } catch {
                        resolve(.parsingError(error))
                    }

                    // if neither error nor chunks then data is corruted
                    resolve(.unhandled(data, response, error))
                })
                task.resume()
            }
        }
    }
}
