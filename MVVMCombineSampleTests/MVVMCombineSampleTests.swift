//
//  MVVMCombineSampleTests.swift
//  MVVMCombineSampleTests
//
//  Created by Hanan Ahmed on 2/22/22.
//

import XCTest
import Combine

@testable import MVVMCombineSample

class MVVMCombineSampleTests: XCTestCase {
    
    private var subject: LinkHistoryViewModel!
    private var mockLinkShortenedService: MockLinkShortenedService!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()

        mockLinkShortenedService = MockLinkShortenedService()
        subject = LinkHistoryViewModel(shortenURLService: mockLinkShortenedService)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        mockLinkShortenedService = nil
        subject = nil

        super.tearDown()
    }
    
    func test_shortened_url_shouldCallService() {
        // when
        subject.enterLink(link: "https://www.facebook.com")

        // then
        XCTAssertEqual(mockLinkShortenedService.getCallsCount, 1)
        XCTAssertEqual(mockLinkShortenedService.getArguments.first, "https://www.facebook.com")
    }
    
    func test_shortenedURL_givenURLWasPerformed_shouldUseCurrentURL() {
        subject.enterLink(link: "https://www.facebook.com")
        XCTAssertEqual(mockLinkShortenedService.getCallsCount, 1)
        XCTAssertEqual(mockLinkShortenedService.getArguments.first, "https://www.facebook.com")
    }

    func test_shortenedURL_givenServiceCallSucceeds_shouldAddShortenedURL() {
        // given
        mockLinkShortenedService.getResult = .success(Constants.link)

        // when
        subject.enterLink(link: "https://www.facebook.com")

        // then
        XCTAssertEqual(mockLinkShortenedService.getCallsCount, 1)
        XCTAssertEqual(mockLinkShortenedService.getArguments.last, "https://www.facebook.com")
//        subject.$links
//            .sink { XCTAssertEqual($0, Constants.link) }
//            .store(in: &cancellables)

        subject.$state
            .sink { XCTAssertEqual($0, .finishedLoading) }
            .store(in: &cancellables)
    }
    
    func test_shortenedURL_givenServiceCallFails_shouldUpdateStateWithError() {
        // given
        mockLinkShortenedService.getResult = .failure(MockError.error)

        // when
        subject.enterLink(link: "https://www.facebook.com")

        // then
        XCTAssertEqual(mockLinkShortenedService.getCallsCount, 1)
        XCTAssertEqual(mockLinkShortenedService.getArguments.last, "https://www.facebook.com")
        subject.$links
            .sink { XCTAssert($0.isEmpty) }
            .store(in: &cancellables)

        subject.$state
            .sink { XCTAssertEqual($0, .error(.addShortenLink)) }
            .store(in: &cancellables)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

// MARK: - Helpers

extension MVVMCombineSampleTests {
    enum Constants {
        static let link = ShortLinkData(status: true, shortLinkResult: ShortLink(code: "1", shortLink: "shortenurl/hey", fullShortLink: "https://www.facebook.com/fullshort", shortLink2: "https://www.facebook.com/short", fullShortLink2: "https://www.facebook.com", shareLink: "share", fullShareLink: "shareFull", originalLink: "https://www.facebook.com"))
    }
}

// MARK: - MockError

enum MockError: Error {
    case error
}
