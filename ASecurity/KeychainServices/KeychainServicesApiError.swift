import Foundation
import Security

public struct KeychainServicesApiError: Error, CustomStringConvertible {
    
    let status: OSStatus
    
    // MARK: CustomStringConvertible
    
    public var description: String {
        if #available(iOS 11.3, *), let message = SecCopyErrorMessageString(status, nil) {
            return "\(status) \(message)"
        } else {
            return "\(status)"
        }
    }
    
}
