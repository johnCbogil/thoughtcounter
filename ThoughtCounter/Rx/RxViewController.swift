//
//  RxViewController.swift
//  ThoughtCounter
//
//  Created by John Bogil on 9/16/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Anchors

class RxViewController: UIViewController {

    // MARK: - Properties
    let disposeBag = DisposeBag()

    lazy var viewModel: RxViewModel = {
        let vm = RxViewModel()
        return vm
    }()

    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RxTableViewCell.self, forCellReuseIdentifier: "RxTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        return tableView
    }()

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        activate(
            tableView.anchor.height.equal.to(view.frame.size.height),
            tableView.anchor.width.equal.to(view.frame.size.width)
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setupBindings() {
        viewModel.thoughts
            .subscribe(onNext: { _ in
                self.tableView.reloadData()
            })
        .disposed(by: disposeBag)
    }
}

extension RxViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.thoughts.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RxTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RxTableViewCell", for: indexPath) as! RxTableViewCell
        let text = viewModel.thoughts.value[indexPath.row]
        cell.configure(text: text)
        return cell
    }
}
