import Foundation
import Alamofire

class LoginVForumManager {
    static var shared = LoginVForumManager()
    
    func login(url: String, params: [String: Any]) -> Bool {
        var result: Bool = false // Default value is false
        
        let rawUrl = URL(string: url)
        
        guard let url = rawUrl else {
            return result
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response{
            response in
            
            if let data = response.data {
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    
                    if let success = loginResponse.success {
                        result = success
                        
                        if let accessToken = loginResponse.result?.accessToken {
                            TokenManager.shared.updateAccessTokenIntoLocal(accessToken: accessToken)
                        }
                        if let refreshToken = loginResponse.result?.refreshToken {
                            TokenManager.shared.updateRefreshTokenIntoLocal(refreshToken: refreshToken)
                        }
                    }
                    
                    
                    semaphore.signal()
                } catch {
                    //print(error)
                    result = false
                    semaphore.signal()
                }
            }

        }
        
        semaphore.wait()
        
        return result
    }
}
