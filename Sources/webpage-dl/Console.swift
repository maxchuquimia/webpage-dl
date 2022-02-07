import Foundation

protocol Console {
    func print(_ string: String?)
    func printError(_ error: Error)
    func exit(_ code: Int32)
}

extension Console where Self == _Console  {

    static func new() -> Console {
        _Console()
    }

}

final class _Console: Console {

    func print(_ string: String?) {
        Swift.print(string ?? "")
    }

    func printError(_ error: Error) {
        fputs("WebpageDLError: \(error.localizedDescription)\n", stderr)
    }

    func exit(_ code: Int32) {
        Darwin.exit(code)
    }

}
