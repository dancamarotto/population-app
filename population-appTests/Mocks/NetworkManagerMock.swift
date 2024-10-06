import Foundation
@testable import population_app

final class NetworkManagerMock: NetworkManagerProtocol {
    private(set) var performRequestCalled: Bool = false
    private(set) var requestSpy: URLRequest?
    var returnedValue: Any!
    
    func performRequest<U>(_ request: URLRequest) async throws -> U where U : Decodable {
        performRequestCalled = true
        requestSpy = request
        assert(returnedValue is U, "Returned value is not of the expected type.")
        return returnedValue as! U
    }
}
