//
//  MockURLSession.swift
//  QicNews
//
//  Created by Guest on 05/01/25.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var mockResponses: [URL: (data: Data?, response: URLResponse?, error: Error?)] = [:]

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url, let mockResponse = MockURLProtocol.mockResponses[url] {
            if let data = mockResponse.data {
                client?.urlProtocol(self, didLoad: data)
            }
            if let response = mockResponse.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let error = mockResponse.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // No implementation needed
    }
}


extension URLSession {
    static func mockSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}
