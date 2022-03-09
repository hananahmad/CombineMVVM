//
//  MockLinkShortenedService.swift
//  MVVMCombineSampleTests
//
//  Created by Hanan Ahmed on 2/23/22.
//

import Foundation
import Combine
@testable import MVVMCombineSample

final class MockLinkShortenedService: ShortenURLServiceProtocol {
    
    var getArguments: [String?] = []
    var getCallsCount: Int = 0

    var getResult: Result<ShortLinkData, Error> = .success(ShortLinkData())

    
    func shortenURL(url: String?) -> AnyPublisher<ShortLinkData, Error> {
        getArguments.append(url)
        getCallsCount += 1
        return getResult.publisher.eraseToAnyPublisher()
    }
}
