//
//  ShortenURLCellViewModel.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/22/22.
//

import Foundation
import Combine

final class ShortenURLCellViewModel {
    @Published var fullLengthURL: String = ""
    @Published var shortenedURL: String = ""
    @Published var isCopied: Bool = false

    private let linkHistory: ShortLink?

    init(linkHistory: ShortLink) {
        self.linkHistory = linkHistory
        
        setUpBindings()
    }

    private func setUpBindings() {
        fullLengthURL = linkHistory?.originalLink ?? ""
        shortenedURL = linkHistory?.shortLink ?? ""
    }
}

