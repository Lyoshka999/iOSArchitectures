//
//  SearchPresenteer.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Rubtsov on 21.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SearchPresenter {
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    private let searchService = ITunesSearchService()
    
    private func requestApps(with query: String) {
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { apps in
                    guard !apps.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = apps
                }
                .withError {
                    self.viewInput?.showError(error: $0)
            }
        }
    }
    
    private func requestSongs(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { songs in
                    guard !songs.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = songs
                }
                .withError {
                    self.viewInput?.showError(error: $0)
            }
        }
    }
    
}

// MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        if viewInput?.tabBarController?.selectedIndex == 0 {
            self.requestApps(with: query)
        } else {
            self.requestSongs(with: query)
        }
    }
    
    func viewDidSelectItem(_ item: Any) {
        if viewInput?.tabBarController?.selectedIndex == 0 {
            guard let app = item as? ITunesApp else { return }
            let appDetailViewController = AppDetailViewController(app: app)
            self.viewInput?.navigationController?.pushViewController(appDetailViewController, animated: true)
        } else {
            guard let song = item as? ITunesSong else { return }
            let songDetailViewController = SongDetailViewController(song: song)
            self.viewInput?.navigationController?.pushViewController(songDetailViewController, animated: true)
        }
    }
}
