//
//  HomeViewController.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

import RxSwift
import RxCocoa

typealias HomeDependencies = HasApiService & HasLogger

class HomeViewController: UIViewController, Loadable {

    // MARK: - Subviews
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = .logo
        
        return view
    }()

    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.allowsMultipleSelection = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 80
        
        return view
    }()
    
    private(set) lazy var bioCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 210).isActive = true
        view.backgroundColor = .white
        view.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        return view
    }()
    
    // Dependencies
    let dependencies: HomeDependencies
    let bag = DisposeBag()
    
    init(dependencies: HomeDependencies) {
        // Set properties
        self.dependencies = dependencies

        // Super class
        super.init(nibName: nil, bundle: nil)
                
        // Bindings
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // - Hide the nav bar on this view
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // - Clear selection
        tableView.selectRow(at: nil, animated: false, scrollPosition: .none)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view
        view.backgroundColor = .white
        
        // Configure the nav bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        install()
    }
}

// MARK: - Private

private extension HomeViewController {
    
    func install() {
        headerView.cover(with: logoImageView)
        
        view.add(view: headerView) {
            NSLayoutConstraint
                .activate([
                    $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
                ])
        }
        
        view.add(view: tableView) {
            NSLayoutConstraint
                .activate([
                    $0.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 2),
                    $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        }
    }
}
