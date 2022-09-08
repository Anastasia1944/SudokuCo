//
//  String+Extensions.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 08.09.2022.
//

import UIKit

extension String {
    func getViewController() -> UIViewController? {
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            if let viewControllerType = NSClassFromString("\(appName).\(self)") as? UIViewController.Type {
                return viewControllerType.init()
            }
        }
        return nil
    }
}

