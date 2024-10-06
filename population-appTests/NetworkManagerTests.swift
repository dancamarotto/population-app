import XCTest
@testable import population_app

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    var urlSession: URLSessionMock!
    
    private var dummyURLRequest: URLRequest {
        let url = URL(string: "http://test.com")!
        return URLRequest(url: url)
    }
    
    override func setUp() {
        super.setUp()
        urlSession = URLSessionMock()
        sut = NetworkManager(urlSession: urlSession)
        
        urlSession.returnedURLResponse = URLResponse()
        urlSession.returnedData = DummyDecodable.jsonData
    }
    
    override func tearDown() {
        super.tearDown()
        urlSession = nil
        sut = nil
    }
    
    // MARK: - Tests
    
    func testPerformRequestReturnsExpectedData() async throws {
        // When
        let result: DummyDecodable = try await sut.performRequest(dummyURLRequest)
        
        // Then
        XCTAssertEqual(result.name, "dummy-decodable")
    }
    
    func testPerformRequestCallsURLSession() async throws {
        // When
        let _: DummyDecodable = try await sut.performRequest(dummyURLRequest)
        
        // Then
        XCTAssertTrue(urlSession.dataForRequestCalled)
    }
}

// MARK: - DummyDecodable

fileprivate struct DummyDecodable: Decodable {
    let name: String
    
    static var jsonData: Data {
        """
        {
            "name": "dummy-decodable"
        }
        """.data(using: .utf8)!
    }
}
