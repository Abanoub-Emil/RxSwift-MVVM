//
//  MainPresenter.swift
//  RxSwift-Tutorial
//
//  Created by Abanoub Emil on 19/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainPresenterProtocl {
    var items: PublishSubject<[Product]> { get }
    var testPublishSubject: PublishSubject<[String]> { get }
    var testBehaviourSubject: BehaviorSubject<[String]> { get }
    var testReplaySubject: ReplaySubject<[String]> { get }
    func fetchItems()
    func justExample() -> Observable<String>
    func observableOfExample() -> Observable<String>
    func observableFromExample() -> Observable<String>
    func publishSubjectExample()
    func behaviourSubjectExample()
    func replaySubjectExample()
}

class MainPresenter: MainPresenterProtocl {
    var str1 = ""
    var str2 = ""
    var str3 = ""
    var strArray = ["initial value"]
    var testPublishSubject = PublishSubject<[String]>()
    lazy var testBehaviourSubject = BehaviorSubject<[String]>(value: strArray)
    var testReplaySubject = ReplaySubject<[String]>.create(bufferSize: 2)
    var items = PublishSubject<[Product]>()
    
    func fetchItems() {
        let products = [
            Product(imageName: "house", title: "home"),
            Product(imageName: "gear", title: "Settings"),
            Product(imageName: "person", title: "Profile"),
            Product(imageName: "airplane", title: "Flight"),
            Product(imageName: "bell", title: "Activity")
        ]
        
        items.onNext(products)
        items.onCompleted()
    }
}

extension MainPresenter {
    
    func changeStrTo(_ str: String, onVariable: inout String) {
        onVariable = str
    }
    
    func justExample() -> Observable<String> {
        changeStrTo("justExample", onVariable: &str1)
        return Observable.just(str1)
    }
    
    func observableOfExample() -> Observable<String> {
        changeStrTo("observableOfExample", onVariable: &str1)
        changeStrTo("observableOfExample", onVariable: &str2)
        changeStrTo("observableOfExample", onVariable: &str3)
        
        return Observable.of(str1, str2, str3)
    }
    
    func observableFromExample() -> Observable<String> {
        changeStrTo("observableFromExample", onVariable: &str1)
        changeStrTo("observableFromExample", onVariable: &str2)
        changeStrTo("observableFromExample", onVariable: &str3)
        
        return Observable.from([str1, str2, str3])
    }
    
    func publishSubjectExample() {
        strArray = ["1", "2", "3"]
        testPublishSubject.onNext(strArray)
    }
    
    func behaviourSubjectExample() {
        strArray = ["dog", "cat", "bird"]
        testBehaviourSubject.onNext(strArray)
    }
    
    func replaySubjectExample() {
        strArray = ["1", "2", "3"]
        testReplaySubject.onNext(strArray)
        strArray = ["car", "house", "key"]
        testReplaySubject.onNext(strArray)
        strArray = ["red", "blue", "black"]
        testReplaySubject.onNext(strArray)
    }
}
