import Foundation

extension String {

    func standardHTML() -> String {
        var result = self
        result = result.replacingOccurrences(of: "\n", with: "")

        while result.contains("  ") {
            result = result.replacingOccurrences(of: "  ", with: " ")
        }

        result = result.replacingOccurrences(of: "> <", with: "><")

        return result
    }

}
