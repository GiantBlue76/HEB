//
//  SongListViewControllerBinder.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/16/20.
//

import RxSwift
import RxCocoa

/// - Creates the bindings from the observable sources to the sinks for the song list
extension SongListViewController {

    func bind() {
        /// - Register the cell
        tableView.register(ofType: SongTableViewCell.self)
        
        let trigger =
            rx.methodInvoked(#selector(viewDidLoad))
                .map { _ in () }
                .share(replay: 1)
        
        let output = songListViewModel(dependencies: dependencies, load: trigger)
        
        _ = trigger
            .map { _ in () }
            .takeUntil(rx.deallocated)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.showLoading(message: "Loading Songs...")
            })
        
        let songs = output
            .songs
            .takeUntil(rx.deallocated)
            .share(replay: 1)

        _ = songs
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: SongTableViewCell.defaultIdentifier, cellType: SongTableViewCell.self)) { _, element, cell in
                cell.textLabel?.text = element.title
                cell.detailTextLabel?.text = element.artist
            }
        
        _ = songs
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.hideLoading()
            })
        
        // - Handle errors here
        output.error
            .flatMap { [dependencies] in
                dependencies
                    .logger
                    .log("The songs could not be retrieved: \($0)", .error)
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                // TODO: Show an error here
            })
            .disposed(by: bag)
    }
}
