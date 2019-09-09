import XCTest
import TransportU

final class TransportUTests: XCTestCase {

    struct EmptyResponseRequestMock: Request {
        var body = EmptyBody
        typealias ResultType = EmptyResponse

        // Endpoint description
        let endpoint = "test"
        let method = HTTPMethod.post
        let headers = [String : String]()
        
    }

    func test_givenEmptyResponseReques_whenPerformingRequest_thenResultShouldBeSuccess() {
       let exp = expectation(description: "")

       let transport = fakeTransport(
           for: EmptyResponseRequestMock.self,
           response: Data()
       )

       transport.perform(
           EmptyResponseRequestMock()
       ).onComplete { (result) in
           if case .success(_) = result {
               exp.fulfill()
           } else {
               XCTFail("Expected success but received \(result)")
           }
       }

       wait(for: [exp], timeout: 1)
    }

    static var allTests = [
        ("test_givenEmptyResponseReques_whenPerformingRequest_thenResultShouldBeSuccess", test_givenEmptyResponseReques_whenPerformingRequest_thenResultShouldBeSuccess),
    ]
}
