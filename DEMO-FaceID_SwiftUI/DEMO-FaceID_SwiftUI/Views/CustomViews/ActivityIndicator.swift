//
//  ActivityIndicator.swift
//  DEMO-FaceID_SwiftUI
//
//  Created by User on 12.07.2021.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ view: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        view.startAnimating()
    }
}
