//
//  UIViewController+.swift
//  SeSAC-Memo-Core
//
//  Created by taekki on 2022/09/06.
//

import UIKit

extension UIViewController {
    
    public func presentAlert (
        title: String,
        message: String? = nil,
        isIncludedCancel: Bool = false,
        completion: ((UIAlertAction) -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if isIncludedCancel {
            let deleteAction = UIAlertAction(title: "취소", style: .cancel)
            alertController.addAction(deleteAction)
        }

        let okAction = UIAlertAction(title: "확인", style: .default, handler: completion)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

extension UIViewController {
    
    public enum TransitionStyle {
        case present
        case presentNavigation
        case push
        case presentFullScreen
        case presentCrossDisolve
    }
    
    public func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present, handler: ((T) -> Void)? = nil ) {
        
        handler?(viewController)
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
            
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
            
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
            
        case .presentFullScreen:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
            
        case .presentCrossDisolve:
            viewController.modalPresentationStyle = .overFullScreen
            viewController.modalTransitionStyle = .crossDissolve
            self.present(viewController, animated: true)
        }
    }
}
