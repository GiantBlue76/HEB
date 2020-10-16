//
//  HomeViewControllerBinder.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

import RxSwift
import RxCocoa

extension HomeViewController {
    
    func bind() {
        bioCollectionView
            .rx
            .setDelegate(self)
            .disposed(by: bag)
        
        bioCollectionView.register(ofType: BioCollectionViewCell.self)
        
        let trigger =
            rx
                .methodInvoked(#selector(UIViewController.viewDidLoad))
                .map { _ in () }
                .share(replay: 1)
        
        let input = BandMemberInput(load: trigger)
        let output = bandMemberViewModel(dependencies: dependencies, input: input)
        
        trigger
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.showLoading(message: "Loading bios...")
            })
            .disposed(by: bag)
        
        _ = output
            .error
            .takeUntil(rx.deallocated)
            .flatMap { [dependencies] in
                dependencies
                    .logger
                    .log("Unable to load bios: \($0.localizedDescription)", .error)
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                // TODO: Show an error here
                self?.hideLoading()
            })
        
        let members = output
            .members
            .takeUntil(rx.deallocated)
            .share(replay: 1)
            
        _ = members
            .observeOn(MainScheduler.instance)
            .bind(to: bioCollectionView.rx.items(cellIdentifier: BioCollectionViewCell.defaultIdentifier, cellType: BioCollectionViewCell.self)) { _, element, cell in
                cell.model = element
            }
        
        _ = members
            .map { _ in () }
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.hideLoading()
            })
        
        /// - Bind the table view contents
        tableView
            .rx
            .setDataSource(self)
            .disposed(by: bag)
        
        tableView.reloadData()
        
        /// - Bind selection of the song list cell
        let songSelected = tableView
            .rx
            .itemSelected
            .filter { $0.row == 1 }
            .map { _ in () }
        
        let homeOutput =
            homeViewModel(
                dependencies: dependencies,
                input: HomeViewModelInput(songsSelected: songSelected)
            )
        
        homeOutput.route
            .drive(onNext: { [weak self, dependencies] _ in
                // - As stated in the view model - this would be handled by a router/coordinator or factory.
                // - For purposes of this exercise we are creating the view controller here and pushing.
                self?.navigationController?
                    .pushViewController(
                        SongListViewController(dependencies: dependencies),
                        animated: true
                    )
            })
            .disposed(by: bag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 120, height: 120)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: BioTableViewCell = tableView.dequeueCell(path: indexPath)
            cell.collection = bioCollectionView
            return cell
            
        case 1:
            let cell: MusicTableViewCell = tableView.dequeueCell(path: indexPath)
            return cell
            
        default:
            fatalError("There are no cells for this index")
        }
    }
}
