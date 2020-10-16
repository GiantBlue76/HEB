//
//  SongListViewController.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/16/20.
//

import UIKit

import RxSwift
import RxCocoa

class SongListViewController: UIViewController, Loadable {

    // MARK: - Subviews
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.allowsSelection = false
        view.rowHeight = 50
        view.estimatedRowHeight = 50
        
        return view
    }()

    // Injected dependencies
    let dependencies: HasApiService & HasLogger
    
    // Rx dispose bag
    let bag = DisposeBag()
    
    init(dependencies: HasApiService & HasLogger) {
        self.dependencies = dependencies
        
        // Super class init
        super.init(nibName: nil, bundle: nil)
        
        // Data binding
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        // Configure the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Install subviews
        install()
    }
}

// MARK: - Private

private extension SongListViewController {
    
    func install() {
        view.cover(with: tableView)
    }
}
