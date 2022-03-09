//
//  LinkHistoryViewModel.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import Foundation
import Combine

enum LinkHistoryViewModelError: Error, Equatable {
    case addShortenLink
}

enum LinkHistoryViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(LinkHistoryViewModelError)
    case emptyTextField
    case validText
}

final class LinkHistoryViewModel {
    enum Section { case shortLink }

    @Published private(set) var links: [ShortLink] = []
    @Published private(set) var state: LinkHistoryViewModelState = .finishedLoading
    
    private var enteredOriginalLink: String = ""
    
    private let shortenURLService: ShortenURLServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(shortenURLService: ShortenURLServiceProtocol = ShortenURLService()) {
        self.shortenURLService = shortenURLService
    }

    func enterLink(link: String) {
        enteredOriginalLink = link
        shortenedURL(with: link)
    }
    
    func validateLink(link: String) {
        validateURL(with: link)
    }

    func retryLink() {
        shortenedURL(with: enteredOriginalLink)
    }
    
    
}

extension LinkHistoryViewModel {
    private func shortenedURL(with originalLink: String?) {
        
        guard let originalLink = originalLink, !originalLink.isEmpty else {
            self.state = .emptyTextField
            return
        }
        
        state = .loading
        
        let originalLinkCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.state = .error(.addShortenLink)
            case .finished:
                self?.state = .finishedLoading
            }
        }
        
        let originalLinkValueHandler: (ShortLinkData) -> Void = { [weak self] shortLink in
            self?.links.append(shortLink.shortLinkResult ?? ShortLink())
        }
        
        shortenURLService
            .shortenURL(url: originalLink)
            .sink(receiveCompletion: originalLinkCompletionHandler, receiveValue: originalLinkValueHandler)
            .store(in: &bindings)
    }
    
    private func validateURL(with originalLink: String?) {
        
        guard let originalLink = originalLink, !originalLink.isEmpty else {
            self.state = .emptyTextField
            return
        }
        
        self.state = .validText
    }
}


