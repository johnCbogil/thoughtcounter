//
//  RxViewModel.swift
//  ThoughtCounter
//
//  Created by John Bogil on 9/16/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct RxViewModel {

    // MARK: PROPERTIES
    let disposeBag = DisposeBag()
    let thoughts = BehaviorRelay<[String]>(value: ["one", "two", "three"])


    // MARK: INPUTS
    // MARK: OUTPUTS

}

