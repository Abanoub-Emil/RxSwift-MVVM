//
//  ViewController.swift
//  RxSwift-Tutorial
//
//  Created by Abanoub Emil on 19/03/2022.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    let presenter = MainPresenter()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindTableData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testJustObservable()
        testObservableOf()
        testObservableFrom()
        testPublishSubject()
        testBehaviourSubject()
        testReplaySubject()
    }
    
    func bindTableData() {
        presenter.items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, item, cell in
            cell.textLabel?.text = item.title
            cell.imageView?.image = UIImage(systemName: item.imageName)
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Product.self).bind { item in
            print(item.title)
        }.disposed(by: bag)
        
        presenter.fetchItems()
    }
    
}

extension ViewController {
    func testJustObservable() {
        presenter.justExample().subscribe { event in
            print(event)
        }.disposed(by: bag)
        print()
    }
    
    func testObservableOf() {
        presenter.observableOfExample().subscribe { event in
            print(event)
        }.disposed(by: bag)
        print()
    }
    
    func testObservableFrom() {
        presenter.observableFromExample().subscribe { event in
            print(event)
        }.disposed(by: bag)
        print()
    }
    
    func testPublishSubject() {
        presenter.publishSubjectExample() // nothing will be executed before subscibe
        presenter.testPublishSubject.subscribe { event in
            print(event.element ?? [])
        }.disposed(by: bag)
        presenter.publishSubjectExample()
        print()
    }
    
    func testBehaviourSubject() {   // Recieve 1 old value and the upcoming values
        presenter.testBehaviourSubject.subscribe { event in
            print(event.element ?? [])
        }.disposed(by: bag)
        presenter.behaviourSubjectExample()
        print()
    }
    
    func testReplaySubject() { // it works like behavior subject but you can determine the number of required old values 
        presenter.replaySubjectExample()
        presenter.testReplaySubject.subscribe { event in
            print(event.element ?? [])
        }.disposed(by: bag)
        print()
    }
    
}
