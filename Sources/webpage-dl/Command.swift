import ArgumentParser
import Foundation

@main
struct Command: ParsableCommand {

    struct Options {
        let width: UInt
        let height: UInt
        let timeout: TimeInterval
        let delay: UInt?
        let expression: String
        let url: String

        static let `default` = Options(
            width: 500,
            height: 500,
            timeout: 20,
            delay: nil,
            expression: "document.documentElement.outerHTML.toString()",
            url: ""
        )
    }

    @Option(name: .shortAndLong, help: "The width of the simulated web page.")
    var width: UInt = Options.default.width

    @Option(name: .shortAndLong, help: "The height of the simulated web page.")
    var height: UInt = Options.default.height

    @Option(name: .long, help: "The maximum number of seconds the program should run for before exiting (in the event of slow loading).")
    var timeout: TimeInterval = Options.default.timeout

    @Option(name: .shortAndLong, help: "An additional time to wait before executing 'expression'.")
    var delay: UInt?

    @Option(name: .long, help: "The JavaScript expression to run. The output from this expression with be printed to stdout before the program exits.")
    var expression: String = Options.default.expression

    @Argument(help: "The URL of the webpage to download.")
    var url: String

    static var _commandName: String { "webpage-dl" }

    func validate() throws {
        guard URL(string: url) != nil else { throw WebpageDLError.invalidURL }
        guard width > 0 else { throw WebpageDLError.invalidWidth }
        guard height > 0 else { throw WebpageDLError.invalidHeight }
        guard !expression.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { throw WebpageDLError.invalidExpression }
    }

    mutating func run() throws {
        let downloader = WebpageDL(
            arguments: Options(
                width: width,
                height: height,
                timeout: timeout,
                delay: delay,
                expression: expression,
                url: url
            )
        )
        downloader.run()

        // The runloop timeout should never happen as the URLRequest's timeout will kick in earlier...
        RunLoop.current.run(until: Date(timeIntervalSinceNow: timeout + 1))
        _ = downloader

        throw WebpageDLError.timeout
    }

}
