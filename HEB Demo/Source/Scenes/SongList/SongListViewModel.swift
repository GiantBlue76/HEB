//
//  SongListViewModel.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/16/20.
//

import RxSwift
import RxCocoa

/// - Functional view model for SonglistViewController

func songListViewModel(dependencies: HasApiService & HasLogger, load: Observable<Void>) -> SongListOutput {
    let loadSongs = load
        .flatMap {
            dependencies
                .api
                .songs()
                .map {
                    $0.map { SongDisplay(title: $0.title, artist: $0.artist) }
                }
                .materialize()
                .filter { $0.isCompleted == false }
        }
        .share(replay: 1)
    
    return SongListOutput(
        songs: loadSongs.compactMap { $0.element },
        error: loadSongs.compactMap { $0.error }
    )
}

/// - Displayable domain object to be sent to the view

struct SongDisplay {
    
    let title: String
    let artist: String
}

/// - Songlist Output

struct SongListOutput {
    
    let songs: Observable<[SongDisplay]>
    let error: Observable<Error>
}
