//
//  EndpointTests.swift
//  WeatherAppTests
//
//  Created by Piotr Olech on 19/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import XCTest
import Alamofire
@testable import WeatherApp

class EndpointTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let properJSONData = """
    {
        "title" : "test",
        "id" : 1
    }
    """.data(using: .utf8)!
    
    private let invalidJSONData = """
    {
        "title" : nil,
        "id" : "1"
    }
    """.data(using: .utf8)!
    
    // MARK: - Tests
    
    func testDecodeEndpointDataShouldNoThrow() {
        let endpoint = Endpoint<TestCodableObject>(path: "")
        
        XCTAssertNoThrow(try endpoint.decode(properJSONData))
    }
    
    func testDecodeEndpointDataShouldThrow() {
        let endpoint = Endpoint<TestCodableObject>(path: "")
        
        XCTAssertThrowsError(try endpoint.decode(invalidJSONData))
    }
    
    func testDecodeEndpointDataShouldReturnInitializedObject() {
        let endpoint = Endpoint<TestCodableObject>(path: "")

        let data = try! endpoint.decode(properJSONData)
        
        XCTAssertEqual(data.title, "test")
        XCTAssertEqual(data.id, 1)
    }
    
    func testInitEndpointWithNotDefaultValues() {
        let path = "test"
        let method: HTTPMethod = .post
        let parameters: Parameters = ["test": "test"]
        let encoding: URLEncoding = URLEncoding.httpBody
        let headers: HTTPHeaders = ["test": "test"]
        let decodeClosure: (Data) throws -> TestCodableObject = { data in
            return try JSONDecoder().decode(TestCodableObject.self, from: data)
        }
        
        let endpoint = Endpoint<TestCodableObject>(path: path, method: method, parameters: parameters, encoding: encoding, headers: headers, decode: decodeClosure)
        
        let endpointParameters = NSDictionary(dictionary: endpoint.parameters ?? [:])
        let expectedParameters = NSDictionary(dictionary: parameters)
        let decodedObject = try! endpoint.decode(properJSONData)
        let expectedDecodedObject = try! decodeClosure(properJSONData)
        XCTAssertEqual(endpoint.path, path)
        XCTAssertEqual(endpoint.method, method)
        XCTAssertEqual(endpointParameters, expectedParameters)
        XCTAssertEqual(endpoint.headers, headers)
        XCTAssertEqual(decodedObject.id, expectedDecodedObject.id)
        XCTAssertEqual(decodedObject.title, expectedDecodedObject.title)
    }
}
