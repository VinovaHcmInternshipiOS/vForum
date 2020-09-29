import Foundation
import Alamofire

class NetworkManager {
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 300
        configuration.timeoutIntervalForResource = 300
        let serverTrustManager = ServerTrustManager(evaluators: ["localhost": DisabledTrustEvaluator()])
        let sessionManager = Session(configuration: configuration, serverTrustManager: serverTrustManager)
        return sessionManager
    }()
}
