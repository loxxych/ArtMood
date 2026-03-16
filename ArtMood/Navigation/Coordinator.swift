//
//  Coordinator.swift
//  ArtMood
//
//  Created by loxxy on 16.03.2026.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}
