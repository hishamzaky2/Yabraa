//
//  NetworkServices.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed
    case jsonParsingFailed
}
class NetworkServices {
    class func callAPI<T: Decodable>(withURL url: String, responseType: T.Type,method: HttpMethod, parameters: [String:Any?]?) -> Observable<T> {
        guard let url = URL(string: url) else {
            return Observable.error(APIError.invalidURL)
        }
        let headers = [
            "Authorization": "Bearer \(UserDefualtUtils.getToken() ?? "")"
        ]
        var request = URLRequest(url:  url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                print(error)
            }
        }
        return URLSession.shared.rx.response(request: request)
            .map { response, data in
                guard 200..<300 ~= response.statusCode else {
                    throw APIError.requestFailed
                }
                return data
            }
            .map { data in
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(T.self, from: data)
                    return response
                } catch (let error){
                    print(error)
                    throw APIError.jsonParsingFailed
                }
            }
            .asObservable()
    }
}
