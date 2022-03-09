//
//  ShortenURLService.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/22/22.
//

import Foundation
import Combine

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol ShortenURLServiceProtocol {
    func shortenURL(url: String?) -> AnyPublisher<ShortLinkData, Error>
}

final class ShortenURLService: ShortenURLServiceProtocol {
    
    func shortenURL(url: String?) -> AnyPublisher<ShortLinkData, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<ShortLinkData, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlRequest(shortenURL: url) else {
                promise(.failure(ServiceError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    let shortenURL = try JSONDecoder().decode(ShortLinkData.self, from: data)
                    promise(.success(shortenURL))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlRequest(shortenURL: String?) -> URLRequest? {
        
        let url = URL(
            string: "https://api.shrtco.de/v2/shorten?\(shortenURL ?? "")"
        )!

        var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )!
        
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "api.shrtco.de/v2"
//        components.path = "/shorten"
//        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "%2F", with: "")

        if let shortenURL = shortenURL, !shortenURL.isEmpty {
            components.queryItems = [
                URLQueryItem(name: "url", value: shortenURL)
            ]
        }
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 15.0
        urlRequest.httpMethod = "POST"
        return urlRequest
    }
    
    // Used but removed due to nominal cost work
   /* var jsonDecoder: JSONDecoder {
       let decoder = JSONDecoder()
       decoder.keyDecodingStrategy = .convertFromSnakeCase
       return decoder
    }*/
}

