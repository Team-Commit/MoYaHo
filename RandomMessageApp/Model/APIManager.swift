//import Foundation
//
//enum APIEndpoint: String {
//    case test = "/test"
//    case testMessage = "/test/message"
//    case sendMessage = "/send/message"
//    case requestToken = "/v1/auth/sign-in"
//}
//
//enum RequestMethod: String {
//    case get = "GET"
//    case post = "POST"
//}
//
//class APIManager {
//
//    static let shared = APIManager()
//    private let baseURL = "http://158.247.255.105:8000"
//    private let session = URLSession.shared
//
//    private init() {}
//
//    //MARK: - Test
//    func fetchTestData(completion: @escaping (Result<String, Error>) -> Void) {
//        let endpoint = APIEndpoint.test.rawValue
//        guard let url = URL(string: baseURL + endpoint) else {
//            completion(.failure(APIError.invalidURL))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = RequestMethod.get.rawValue
//
//        let task = session.dataTask(with: request) { data, response, error in
//
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completion(.failure(APIError.invalidResponse))
//                return
//            }
//
//            if let message = String(data: data, encoding: .utf8) {
//                completion(.success(message))
//            } else {
//                completion(.failure(APIError.dataDecodingError))
//            }
//        }
//
//        task.resume()
//    }
//
//    //MARK: - Request Token
//
//    func requestTokenWithUUID(uuid: String, completion: @escaping (Result<String, Error>) -> Void) {
//        let endpoint = APIEndpoint.requestToken.rawValue
//        guard let url = URL(string: baseURL + endpoint) else {
//            print("APIError");         completion(.failure(APIError.invalidURL) )
//            return
//        }
//
//        //상태코드 적어놓기
//
//        var request = URLRequest(url: url)
//        request.httpMethod = RequestMethod.post.rawValue
//        request.httpBody = "uuid=\(uuid)".data(using: .utf8)
////        request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//        let task = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//            print(":::response\(response.statusCode)")
//
//            guard let data = data, let token = String(data: data, encoding: .utf8) else {
//                completion(.failure(APIError.dataDecodingError))
//                return
//            }
//
//
//
//            completion(.success(token))
//            print("::::::유저토큰_\(token)")
//        }
//        task.resume()
//    }


import Foundation

enum APIEndpoint: String {
    case test = "/test"
    case testMessage = "/test/message"
    case sendMessage = "/send/message"
    case requestToken = "/v1/auth/sign-in"
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

struct TokenRequest: Codable {
    let deviceId: String
}

struct TokenResponse: Codable {
    let data: TokenData
}

struct TokenData: Codable {
    let accessToken: String
}



class APIManager {
    
    static let shared = APIManager()
    private let baseURL = "http://158.247.255.105:8000"
    private let session = URLSession.shared
    
    private init() {}
    
    //MARK: - Test
    func fetchTestData(completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = APIEndpoint.test.rawValue
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue

        let task = session.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }

            if let message = String(data: data, encoding: .utf8) {
                completion(.success(message))
            } else {
                completion(.failure(APIError.dataDecodingError))
            }
        }

        task.resume()
    }
    
    //MARK: - Request Token
    func requestTokenWithUUID(uuid: String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = APIEndpoint.requestToken.rawValue
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = RequestMethod.post.rawValue
        
        let body = TokenRequest(deviceId: uuid)
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            completion(.failure(APIError.dataEncodingError))
            return
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            if let jsonData = data {
                do {
                    let decoder = JSONDecoder()
                    let tokenResponse = try decoder.decode(TokenResponse.self, from: jsonData)
                    completion(.success(tokenResponse.data.accessToken))
                } catch {
                    completion(.failure(APIError.dataDecodingError))
                }
            } else {
                completion(.failure(APIError.unknownError))
            }
        }
        task.resume()
    }


    
    // MARK: - Manage UUID
    static func storeUUIDInKeychain(uuid: String) {
        let uuidData = Data(uuid.utf8)
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userUUID",
            kSecValueData as String: uuidData
        ]
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    static func getUUIDFromKeychain() -> String? {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userUUID",
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            if let data = dataTypeRef as? Data, let uuid = String(data: data, encoding: .utf8) {
                return uuid
            }
        }
        
        return nil
    }
    
    // MARK: - Manage Token
    static func storeTokenInKeychain(token: String) {
        let tokenData = Data(token.utf8)
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userToken",
            kSecValueData as String: tokenData
        ]
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case dataDecodingError
    case dataEncodingError
    case unknownError
}
