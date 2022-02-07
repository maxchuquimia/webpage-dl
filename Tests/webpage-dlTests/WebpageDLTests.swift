import XCTest
import class Foundation.Bundle
@testable import webpage_dl
import Telegraph

final class WebpageDLTests: XCTestCase {

    var server: Server!
    var consoleSpy: ConsoleSpy!
    let port: Endpoint.Port = 9000
    lazy var baseURL = "http://localhost:\(port)/"

    override func setUpWithError() throws {
        try super.setUpWithError()
        server = Server()
        consoleSpy = ConsoleSpy()
        try server.start(port: port, interface: "localhost")
        server.serveDirectory(bundledResourcesDir)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        server.stop(immediately: true)
    }

    func testSimpleLoading() throws {
        // GIVEN
        let sut = WebpageDL(
            console: consoleSpy,
            arguments: .with(url: baseURL.appending("simple.html"))
        )

        // WHEN
        sut.run()

        // THEN
        wait(for: [consoleSpy.finishWithSuccessExpectation], timeout: 60.0)
        XCTAssertEqualAfterReformatting(consoleSpy.capturedPrintMessages[0], self.resource("simple.html"))
        XCTAssertEqual(consoleSpy.capturedPrintMessages.count, 1)
        XCTAssertTrue(consoleSpy.capturedErrors.isEmpty)
        XCTAssertEqual(consoleSpy.capturedExitCode, 0)
    }

    func testLoadingElement() throws {
        // GIVEN
        let sut = WebpageDL(
            console: consoleSpy,
            arguments: .with(
                expression: "document.getElementById(\"test_id\").innerHTML.toString()",
                url: baseURL.appending("element.html")
            )
        )

        // WHEN
        sut.run()

        // THEN
        wait(for: [consoleSpy.finishWithSuccessExpectation], timeout: 60.0)
        XCTAssertEqualAfterReformatting(consoleSpy.capturedPrintMessages[0], "hello world")
        XCTAssertEqual(consoleSpy.capturedPrintMessages.count, 1)
        XCTAssertTrue(consoleSpy.capturedErrors.isEmpty)
        XCTAssertEqual(consoleSpy.capturedExitCode, 0)
    }

    func testSimpleLoadingWithDelay() throws {
        // GIVEN
        let sut = WebpageDL(console: consoleSpy, arguments: .with(delay: 10, url: baseURL.appending("simple.html")))

        // WHEN
        let startDate = Date()
        sut.run()

        // THEN
        wait(for: [consoleSpy.finishWithSuccessExpectation], timeout: 20.0)
        XCTAssertGreaterThanOrEqual(Date().timeIntervalSince(startDate), 10)
    }

    func testErrorLoading() throws {
        // GIVEN
        let sut = WebpageDL(console: consoleSpy, arguments: .with(url: baseURL.appending("does-not-exist.html")))

        // WHEN
        server.stop(immediately: true)
        sut.run()

        // THEN
        wait(for: [consoleSpy.finishWithErrorExpectation], timeout: 60.0)
        XCTAssertEqual(consoleSpy.capturedErrors.count, 1)
        XCTAssertTrue(consoleSpy.capturedPrintMessages.isEmpty)
        XCTAssertEqual(consoleSpy.capturedExitCode, 2)
    }

}

