//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    public var app: ITunesApp
    
    lazy var headerViewController = AppDetailHeaderViewController(app: self.app)
    
    // MARK: - Construction
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    // MARK: - Private Functions
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .never
        addHeaderViewController()
        addDescriptionViewController()
    }
    
    private func addHeaderViewController() {
        addChild(headerViewController)
        view.addSubview(headerViewController.view)
        headerViewController.didMove(toParent: self)
        
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    private func addDescriptionViewController() {
        
        // TODO: ДЗ, сделать другие сабмодули
        
        let descriptionViewController = UIViewController()
        addChild(descriptionViewController)
        view.addSubview(descriptionViewController.view)
        descriptionViewController.didMove(toParent: self)
        
        descriptionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor),
            descriptionViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            descriptionViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            descriptionViewController.view.heightAnchor.constraint(equalToConstant: 250.0)
        ])
    }
}
