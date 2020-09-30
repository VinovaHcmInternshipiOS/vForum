//
//  Networking.swift
//  ANT Parent
//
//  Created by Liberty Nguyen on 18/09/2020.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import Alamofire

public protocol AppServerConfiguration {
    var baseURL: String { get }
    //var baseDomain: String { get }
    var defaultHeaders: [String: String] { get }
}

public enum Task {
    /// All basic request task.
    case request
    case download
    case upload
}

public protocol TargetType {
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    /// The HTTP method used in the request.
    var method: Alamofire.HTTPMethod { get }
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? { get }
    // The header to be incoded in the request
    var headers: [String: String]? {get}
    //The encoding for the parameter
    var encoding: ParameterEncoding {get}
    /// The type of HTTP task to be performed.
    var task: Task { get }
}

extension Session {
    // TODO: computed property to create configuration session manager
}

struct RemoteAPIProvider {
    let configuration: AppServerConfiguration
    // TODO: setup your logging
    var logManager: Any?
    
    private var alamoFireManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 600
        configuration.timeoutIntervalForResource = 600
        let alamoFireManager = Alamofire.Session(configuration: configuration)
        return alamoFireManager
    }()
    
    init(configuration: AppServerConfiguration) {
        self.configuration = configuration
    }
}

extension RemoteAPIProvider {
    public static func testingMethod() {
            let baseUrl = URL(string: "https://navig8-fixture-board-api.vinova.sg/")!
            let url = baseUrl.appendingPathComponent("api/Pool")
            let params: [String: Any]? = nil
            let method = HTTPMethod.get
            var headerDict: [String: String] = [:]
            
    //        headerDict["Authorization"] = "Bearer " + "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImV4dF92aW5vdmEiLCJVc2VySWQiOiI1IiwibmJmIjoxNTk4OTQ2MTk3LCJleHAiOjE2MzA0ODIxOTcsImlhdCI6MTU5ODk0NjE5N30.azI5UfK3lQ9siUpMa7IdJn3DLoqWpYNmAaOkqw8tt4g"
            
            headerDict["Authorization"] = "Bearer " + "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjZiZmQ5ZTRjMDFiYjQxODhjMTEyYzciLCJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwicm9sZSI6ImFkbWluIiwiZGlzcGxheV9uYW1lIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjAxMjY3Mzc3LCJleHAiOjE2MDEyNzA5Nzd9.JgJ7IlZV5L9BIyhPLyZ2FIQdZf1SwcF2H-ryubQ2d6M"
            let encoding = JSONEncoding.default
            URLCache.shared.removeAllCachedResponses()
            //Log.debug("Request with target \(target) \n -> URL: \(url) \n -> Method: \(method) \n -> Params: \(String(describing: params)) \n ->Header: \(headers) \n ->Encoding: \(encoding)")
            
            let headers = HTTPHeaders(headerDict)
            
            let dataRequest = AF
                .requestWithoutCache(url,
                                     method: method,
                                     parameters: params,
                                     encoding: encoding,
                                     headers: headers)
                .validate()
                
            dataRequest.responseJSON { response in
                    if let error = response.error {
                        print("Request \(String(describing: response.request)) error :\(error.localizedDescription)")
                    } else {
                        dataRequest.handleFreeJSON { (response) in
                            
                            print("***********************RESPONSE***************************")
                            print("Path: \(url.absoluteString)")
                            print("Data: ", response.value)
                            
                            if let error = response.error {
                                print("*ERROR: \(error)");
                            } else {
                            }
                        }
                    }
        }
    }
    
    public static func testingMethod(_ accessToken: String, _ urlString: String) {
        //let baseUrl = URL(string: "https://navig8-fixture-board-api.vinova.sg/")!
        let baseUrl = URL(string: urlString)!
        let url = baseUrl.appendingPathComponent("api/Pool")
        let params: [String: Any]? = nil
        let method = HTTPMethod.get
        var headerDict: [String: String] = [:]
        
//        headerDict["Authorization"] = "Bearer " + "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImV4dF92aW5vdmEiLCJVc2VySWQiOiI1IiwibmJmIjoxNTk4OTQ2MTk3LCJleHAiOjE2MzA0ODIxOTcsImlhdCI6MTU5ODk0NjE5N30.azI5UfK3lQ9siUpMa7IdJn3DLoqWpYNmAaOkqw8tt4g"
        
        headerDict["Authorization"] = "Bearer " + "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjZiZmQ5ZTRjMDFiYjQxODhjMTEyYzciLCJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwicm9sZSI6ImFkbWluIiwiZGlzcGxheV9uYW1lIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjAxMjcxMzQzLCJleHAiOjE2MDEyNzQ5NDN9.o4UDNy3ddBDz2eaJh0LRadLgNapL7HlyG6BRXguJlCA"
        let encoding = JSONEncoding.default
        URLCache.shared.removeAllCachedResponses()
        //Log.debug("Request with target \(target) \n -> URL: \(url) \n -> Method: \(method) \n -> Params: \(String(describing: params)) \n ->Header: \(headers) \n ->Encoding: \(encoding)")
        
        let headers = HTTPHeaders(headerDict)
        
        let dataRequest = AF
            .requestWithoutCache(baseUrl,
                                 method: method,
                                 parameters: params,
                                 encoding: encoding,
                                 headers: headers)
            .validate()
            
        dataRequest.responseJSON { response in
                if let error = response.error {
                    print("Request \(String(describing: response.request)) error :\(error.localizedDescription)")
                } else {
                    dataRequest.handleFreeJSON { (response) in
                        
                        print("***********************RESPONSE***************************")
                        print("Path: \(url.absoluteString)")
                        print("Data: ", response.value)
                        
                        if let error = response.error {
                            print("*ERROR: \(error)");
                        } else {
                        }
                    }
                }
        }
    }
    
    public func requestFreeJSON(target: TargetType, accessToken: String?, fullfill: @escaping ([String: Any]) -> Void, reject: @escaping (Error) -> Void ) -> DataRequest {
        print("***********************REQUEST***************************")
        print(target.path)
        print(target.method)
        print(target.parameters ?? "Nil Parameter")
        print(target.headers ?? "nil Header")
        
        return self.dataRequest(target: target, accessToken: accessToken, complete: { (dataRequest) in
            dataRequest.handleFreeJSON { (response: DataResponse<[String: Any], Error>) -> Void in
                print("***********************RESPONSE***************************")
                print("Path: \(target.path)")
                print("Data: ", response.value ?? "empty")
                
                if let error = response.error {
                    print("*ERROR: \(error.localizedDescription)");
                    reject(self.captureError(responseData: response.data, errorResponse: error))
                } else {
                    fullfill(response.value!)
                }
            }
        }) { (error) in
            reject(error)
        }
    }
    
    public func request<T: Decodable>(target: TargetType, accessToken: String?, keyPath: String? = nil, fullfill: @escaping (T?) -> Void, reject: @escaping (Error) -> Void ) -> DataRequest {
        print("***********************REQUEST***************************")
        print(target.path)
        print(target.method)
        print(target.parameters ?? "Nil Parameter")
        print(target.headers ?? "nil Header")
        
        return self.dataRequest(target: target, accessToken: accessToken, complete: { (dataRequest) in
            dataRequest.handleJsonObject(keyPath: keyPath) { (response: DataResponse<T, Error>) -> Void in
                print("***********************RESPONSE***************************")
                print("Path: \(target.path)")
                print("Data: ", response.value ?? "empty")
                
                if let error = response.error {
                    print("*ERROR: \(error.localizedDescription)");
                    reject(self.captureError(responseData: response.data, errorResponse: error))
                } else {
                    fullfill(response.value!)
                }
            }
        }, errorBlock: { (error) in
            reject(error)
        })
    }
    
    public func uploadRequest<T: Decodable>(target: TargetType, accessToken: String? = nil, keyPath: String? = nil, fullfill: @escaping (T?) -> Void, reject: @escaping (Error) -> Void ) -> UploadRequest {
        
        return self.dataUploadRequest(target: target, accessToken: accessToken, complete: { (uploadRequest) in
            
            uploadRequest.handleJsonObject(keyPath: keyPath, completionHandler: { (response: DataResponse<T, Error>) in
                
                if let error = response.error {
                    reject(self.captureError(responseData: response.data, errorResponse: error))
                } else {
                    fullfill(response.value!)
                }
            })
        }, errorBlock: { (error) in
            if let error = error {
                reject(error)
            }
        })
    }
}

extension RemoteAPIProvider {
    
    fileprivate func dataRequest(target: TargetType, accessToken: String?, complete:@escaping (DataRequest) -> Void, errorBlock: @escaping(Error) -> Void) -> DataRequest {
        let baseUrl = URL(string: self.configuration.baseURL)!
        let url = baseUrl.appendingPathComponent(target.path)
        let params = target.parameters
        let method = target.method
        var headerDict: [String: String] = [:]
        
        if let token = accessToken {
            headerDict["Authorization"] = "Bearer " + token
        }
        
        if let customHeaders = target.headers {
            // update value to previous headers
            headerDict = headerDict.merging(customHeaders, uniquingKeysWith: { $1 })
        }
        
        let encoding = target.encoding
        URLCache.shared.removeAllCachedResponses()
        //Log.debug("Request with target \(target) \n -> URL: \(url) \n -> Method: \(method) \n -> Params: \(String(describing: params)) \n ->Header: \(headers) \n ->Encoding: \(encoding)")
        
        let headers = HTTPHeaders(headerDict)
        
        let dataRequest = alamoFireManager
            .requestWithoutCache(url,
                                 method: method,
                                 parameters: params,
                                 encoding: encoding,
                                 headers: headers)
            .validate()
            
        dataRequest.responseJSON { response in
                if let error = response.error {
                    print("Request \(String(describing: response.request)) error :\(error.localizedDescription)")
                    errorBlock(error)
                } else {
                    complete(dataRequest)
                }
        }
        
        return dataRequest
    }
    
    fileprivate func dataUploadRequest(target: TargetType, accessToken: String?, complete:@escaping (UploadRequest) -> Void, errorBlock: @escaping(Error?) -> Void) -> UploadRequest {
        let baseUrl = URL(string: configuration.baseURL)!
        let url = baseUrl.appendingPathComponent(target.path)
        let params = target.parameters
        let method = target.method
        var headerDict: [String: String] = [:]
        if let token = accessToken {
            headerDict["Authorization"] =  "Bearer " + token
        }
        
        if let customHeaders = target.headers {
            // update value to previous headers
            headerDict = headerDict.merging(customHeaders, uniquingKeysWith: { $1 })
        }
        
        let headers = HTTPHeaders(headerDict)
        //Log.debug("Request with target \(target) \n -> URL: \(url) \n -> Method: Upload \n -> Params: \(String(describing: params)) \n ->Header: \(headers)")
        
        let uploadRequest = alamoFireManager.upload(multipartFormData: { (multipartFormData) in
            if let params = params {
                for (key, value) in params {
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    }
                }
                for key in params.keys {
                    let value = params[key] as? Data
                    if let value = value {
                        multipartFormData.append(value, withName: key, fileName: key + ".jpg", mimeType: "image/jpeg")
                    }
                }
            }
        }, to: url, usingThreshold: .init(), method: method, headers: headers)
        
        uploadRequest.response {[uploadRequest] (response) in
            switch response.result {
            case .success(_):
                uploadRequest
                    .validate()
                    .responseJSON(completionHandler: { (response) in
                        if let error = response.error {
                            print("Request \(String(describing: response.request)) error :\(error.localizedDescription)")
                        }
                    })
                
                complete(uploadRequest)
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                errorBlock(error)
            }
        }
        
        return uploadRequest
    }
    
    fileprivate func captureError(responseData: Data?, errorResponse: Error ) -> Error {
        if let data = responseData {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                print("Response from error: ", dictionary)
                // TODO:
                // if check response from your server and create it
                // Example VForumError(dictionary)
                // else
                return errorResponse
            } catch {
                return errorResponse
            }
        }
        return errorResponse
    }
}

extension Alamofire.Session {
    @discardableResult
    open func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)// also you can add URLRequest.CachePolicy here as parameter
        -> DataRequest
    {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            // TODO: find a better way to handle error
            print(error)
            return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
        }
    }
}

extension DataRequest {
    func handleFreeJSON(completionHandler: @escaping (_ response: DataResponse<[String: Any], Error>) -> Void) {
        typealias ResponseType = [String: Any]
        do {
            if let data = self.data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
                
                // 1.
                completionHandler(
                    DataResponse<ResponseType, Error>(request: self.request,
                                                      response: self.response,
                                                      data: self.data,
                                                      metrics: self.lastMetrics,
                                                      serializationDuration: .zero,
                                                      result: Result<ResponseType, Error>.success(jsonObject))
                )
                
                return
            }
            
            // 2.
            completionHandler(DataResponse<ResponseType, Error>(request: self.request, response: self.response, data: self.data, metrics: self.lastMetrics, serializationDuration: .zero, result: Result<ResponseType, Error>.failure(NSError(domain: "vinova.internship unexpected response", code: 0, userInfo: ["data": self.data ?? "empty"]))))
            
        }
    }
    
    func handleJsonObject<T: Decodable>(keyPath: String?, completionHandler: @escaping (_ response: DataResponse<T, Error>) -> Void) {
        // handle success request, map data
        do {
            if let data = self.data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
                
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .useDefaultKeys
                decodable.dateDecodingStrategy = .millisecondsSince1970
                
                if let haveKeyPath = keyPath,
                    let keyPathValue = jsonObject[haveKeyPath],
                    let keyPathData = try? JSONSerialization.data(withJSONObject: keyPathValue, options: [.fragmentsAllowed]) {
                    // 1.
                    let result = try decodable.decode(T.self, from: keyPathData)
                    completionHandler(DataResponse<T, Error>(request: self.request, response: self.response, data: self.data, metrics: self.lastMetrics, serializationDuration: .zero, result: Result<T, Error>.success(result)))
                } else {
                    // 2.
                    let result = try decodable.decode(T.self, from: data)
                    completionHandler(DataResponse<T, Error>(request: self.request, response: self.response, data: self.data, metrics: self.lastMetrics, serializationDuration: .zero, result: Result<T, Error>.success(result)))
                }
                
                return
            }
            
            // 3.
            completionHandler(DataResponse<T, Error>(request: self.request, response: self.response, data: self.data, metrics: self.lastMetrics, serializationDuration: .zero, result: Result<T, Error>.failure(NSError(domain: "vinova.internship unexpected response", code: 0, userInfo: ["data": self.data ?? "empty"]))))
            
            
        } catch let error {
            // 4.
            let response = DataResponse<T, Error>(request: self.request, response: self.response, data: self.data, metrics: self.lastMetrics, serializationDuration: .zero, result: Result<T, Error>.failure(error))
            
            completionHandler(response)
        }
    }
}
