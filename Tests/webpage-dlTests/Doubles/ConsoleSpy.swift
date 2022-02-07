import XCTest
@testable import webpage_dl

final class ConsoleSpy: Console {

    let finishWithSuccessExpectation = XCTestExpectation(description: "Finished with success")
    let finishWithErrorExpectation = XCTestExpectation(description: "Finished with error")

    var capturedPrintMessages: [String?] = []
    var capturedErrors: [Error] = []
    var capturedExitCode: Int32 = -1

    func print(_ string: String?) {
        capturedPrintMessages.append(string)
        finishWithSuccessExpectation.fulfill()
    }

    func printError(_ error: Error) {
        capturedErrors.append(error)
        finishWithErrorExpectation.fulfill()
    }

    func exit(_ code: Int32) {
        capturedExitCode = code
    }

}
