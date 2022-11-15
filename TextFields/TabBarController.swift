//
//  TabBarController.swift
//  TextFields
//
//  Created by Beavean on 31.10.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - UI Elements
    
    private lazy var controllers = [SingleTextFieldViewController(textFieldView: NoDigitsView()),
                                    SingleTextFieldViewController(textFieldView: InputLimitView()),
                                    SingleTextFieldViewController(textFieldView: OnlyCharactersView()),
                                    SingleTextFieldViewController(textFieldView: LinkView()),
                                    SingleTextFieldViewController(textFieldView: ValidationRulesView())]
    
    private lazy var controllerIcons = [UIImage(systemName: "1.square"),
                                        UIImage(systemName: "2.square"),
                                        UIImage(systemName: "3.square"),
                                        UIImage(systemName: "4.square"),
                                        UIImage(systemName: "5.square")]
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    //MARK: - Helpers
    
    private func configureViewControllers() {
        guard controllers.count > 0 && controllers.count == controllerIcons.count else { return }
        var createdControllers = [UIViewController]()
        for index in 0..<controllers.count {
            createdControllers.append(templateNavigationController(image: controllerIcons[index], rootViewController: controllers[index]))
        }
        viewControllers = createdControllers
    }
    
    private func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = image
        navigation.navigationBar.barTintColor = .white
        return navigation
    }
}
