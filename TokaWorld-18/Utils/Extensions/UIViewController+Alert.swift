//
//  UIViewController+Alert.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

//MARK: - Alerts
extension UIViewController {
    func presentTwoVLabelAndTwoHButtonAlert(
            titleText: String,
            subtitleText: String,
            leftButtonImageType: ImageType,
            rightButtonImageType: ImageType,
            leftCompletion: (() -> Void)? = nil,
            rightCompletion: (() -> Void)? = nil,
            dismissCompletion: (() -> Void)? = nil
        ) {
            let view = TitleSubtitleAndTwoHButtonView(
                titleText: titleText,
                subtitleText: subtitleText,
                leftButtonImageType: leftButtonImageType,
                rightButtonImageType: rightButtonImageType
            )
            view.configureUI()
            
            view.leftCallback = {
                leftCompletion?()
                self.dismiss(animated: true, completion: dismissCompletion)
            }
            view.rightCallback = {
                rightCompletion?()
                self.dismiss(animated: true, completion: dismissCompletion)
            }
            
            let vc = UIViewController()
            vc.view.addSubview(view)
            view.autoPinEdgesToSuperView()
            
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)
            
            
        }

        func presentEditAlert(
            topCompletion: (() -> Void)? = nil,
            bottomCompletion: (() -> Void)? = nil,
            dismissCompletion: (() -> Void)? = nil
        ) {
            let view = EditAlert()
            view.configureUI()
            
            view.bottomButtonCallback = {
                bottomCompletion?()
                self.dismiss(animated: true, completion: dismissCompletion)
            }
            
            view.topButtonCallback = {
                topCompletion?()
                self.dismiss(animated: true, completion: nil)
            }
            
            view.closeCallback = {
                self.dismiss(animated: true, completion: nil)
            }
            
            let vc = UIViewController()
            vc.view.addSubview(view)
            view.autoPinEdgesToSuperView()
            
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)
        }
    
    func presentTextAlert(
        titleText: String,
        dismissCompletion: ((_ viewController: UIViewController) -> Void)? = nil
    ) {
        let view = BlueTitleAlertView(titleText: titleText)
        view.configureUI()
        
        let vc = UIViewController()
        vc.view.addSubview(view)
        view.autoPinEdgesToSuperView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            dismissCompletion?(vc)
        })
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func presentInternetAlert() {
        let view = TitleSubtitleAlertView(
            titleText: "Connection is lost",
            subtitleText: "Please check your Internet connection and try again."
        )
        view.configureUI()
        
        let vc = UIViewController()
        vc.view.addSubview(view)
        view.autoPinEdgesToSuperView()
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}
