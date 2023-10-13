
import Foundation

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}
