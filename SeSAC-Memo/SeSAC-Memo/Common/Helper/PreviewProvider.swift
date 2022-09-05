//
//  PreviewProvider.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    func showPreview(_ deviceType: DeviceType = .iPhone13Mini) -> some View {
        Preview(viewController: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}

extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {}
    }

    func showPreview(_ deviceType: DeviceType = .iPhone13Mini) -> some View {
        Preview(view: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}
#endif
