import Foundation
@testable import population_app

final class URLSessionMock: URLSessionProtocol {
    private(set) var dataForRequestCalled: Bool = false
    var returnedData: Data!
    var returnedURLResponse: URLResponse!
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataForRequestCalled = true
        return (returnedData, returnedURLResponse)
    }
}
