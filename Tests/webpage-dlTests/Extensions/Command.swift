import Foundation
@testable import webpage_dl

extension Command.Options {

    static func with(
        width: UInt = Self.default.width,
        height: UInt = Self.default.height,
        timeout: TimeInterval = Self.default.timeout,
        delay: UInt? = Self.default.delay,
        expression: String = Self.default.expression,
        url: String = Self.default.url
    ) -> Command.Options {
        Command.Options(
            width: width,
            height: height,
            timeout: timeout,
            delay: delay,
            expression: expression,
            url: url
        )
    }

}
