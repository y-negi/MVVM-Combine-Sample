//
//  LoadingIndicatorView.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/09/06.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import SwiftUI

struct LoadingIndicatorView: View {
    private let isLoading: Bool

    @State private var isAnimation = false

    init(isLoading: Bool) {
        self.isLoading = isLoading
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.black)
                    .opacity(0.01)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                    .disabled(true)
                Circle()
                    .trim(from: 0, to: 0.6)
                    .stroke(AngularGradient(gradient: Gradient(colors: [.gray, .white]),
                                            center: .center),
                            style: StrokeStyle(lineWidth: 8,
                                               lineCap: .round,
                                               dash: [0.1, 16],
                                               dashPhase: 8))
                    .frame(width: 48, height: 48)
                    .rotationEffect(.degrees(self.isAnimation ? 360 : 0))
                    .onAppear {
                        withAnimation(Animation
                            .linear(duration: 1)
                            .repeatForever(autoreverses: false)) {
                                self.isAnimation.toggle()
                        }
                }
            }
            .isHidden(!self.isLoading)
        }
    }
}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView(isLoading: true)
    }
}
