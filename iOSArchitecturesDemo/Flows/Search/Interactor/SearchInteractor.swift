//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей on 16.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchInteractorInput {
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void)
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}

final class SearchInteractor: SearchInteractorInput {
    
    private let searchService = ITunesSearchService()
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void) {
        self.searchService.getApps(forQuery: query) { result in
            completion(result)
        }
    }
    
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        self.searchService.getSongs(forQuery: query) { result in
            completion(result)
        }
    }
}
