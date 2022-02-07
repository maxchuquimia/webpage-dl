import XCTest

extension XCTestCase {

    func XCTAssertEqualAfterReformatting(_ expression1: @autoclosure () -> String?, _ expression2: @autoclosure () -> String?, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(expression1()?.standardHTML(), expression2()?.standardHTML())
    }

    func urlForResource(_ name: String) -> URL {
        bundledResourcesDir.appendingPathComponent(name)
    }

    func resource(_ name: String) -> String {
        try! String(contentsOfFile: urlForResource(name).path)
    }

    var bundledResourcesDir: URL {
        let files = try! FileManager.default.contentsOfDirectory(atPath: productsDir.path)

        for file in files where file.hasSuffix(".bundle") {
            return productsDir
                .appendingPathComponent(file)
                .appendingPathComponent("Contents")
                .appendingPathComponent("Resources")
                .appendingPathComponent("Resources")
        }

        fatalError("Unable to locate bundled resources")
    }

}

private extension XCTestCase {

    var productsDir: URL {
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }

        fatalError("Unable to locate module directory")
    }

}
