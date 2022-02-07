import Foundation
import WebKit

final class WebpageDL: NSObject {

    private let console: Console
    private let arguments: Command.Options
    private var webView: WKWebView?

    init(console: Console = .new(), arguments: Command.Options) {
        self.console = console
        self.arguments = arguments
    }

}

// MARK: - Public

extension WebpageDL {

    func run() {
        webView = WKWebView(frame: NSRect(x: 0, y: 0, width: Int(arguments.width), height: Int(arguments.height)))
        webView?.navigationDelegate = self

        let request = URLRequest(url: URL(string: arguments.url)!, timeoutInterval: arguments.timeout)

        webView?.load(request)
    }

}

extension WebpageDL: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        evaluateExpressionAfterDelay()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        console.printError(error)
        console.exit(1)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        console.printError(error)
        console.exit(2)
    }

}

// MARK: - Private

private extension WebpageDL {

    func evaluateExpressionAfterDelay() {
        if let delay = arguments.delay {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(delay))) { [weak self] in
                self?.evaluateExpression()
            }
        } else {
            evaluateExpression()
        }
    }

    func evaluateExpression() {
        webView?.evaluateJavaScript(arguments.expression) { [console] (html, error) in
            if let error = error {
                console.printError(error)
                console.exit(3)
            } else {
                console.print(html as? String)
                console.exit(0)
            }
        }
    }

}
