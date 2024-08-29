//
//  CircleScrollView.swift
//  ScrollViewOffset
//
//  Created by dongnguyen on 29/8/24.
//

import SwiftUI

struct CircleScrollView: View {
    @State private var scrollViewOffset: CGFloat = 0
    let circleSize: CGFloat = 80
    let spacing: CGFloat = 8
    @State var currentIndex: Int = 0
    var body: some View {
        VStack {
            Text("Current Index: \(currentIndex)")
                .font(.title3)
                .bold()

            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing) {
                        ForEach(0 ..< 20) { _ in
                            GeometryReader { itemGeometry in
                                let scale = calculateScale(geometry: itemGeometry, parentGeometry: geometry)
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: circleSize, height: circleSize)
                                    .scaleEffect(scale)
                                    .animation(.easeOut, value: scrollViewOffset)
                            }
                            .frame(width: circleSize, height: circleSize)
                        }
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal, (geometry.size.width - circleSize) / 2)
                    .background(GeometryReader {
                        Color.clear.preference(key: CircleScrollViewOffsetKey.self, value: $0.frame(in: .global).minX)
                    })
                    .onPreferenceChange(CircleScrollViewOffsetKey.self) { value in
                        self.scrollViewOffset = value
                        currentIndex = abs(Int(value / circleSize))
                    }
                }
                .scrollTargetBehavior(.viewAligned)
            }
        }
    }

    private func calculateScale(geometry: GeometryProxy, parentGeometry: GeometryProxy) -> CGFloat {
        let midX = parentGeometry.frame(in: .global).midX
        let itemMidX = geometry.frame(in: .global).midX
        let distanceFromCenter = abs(midX - itemMidX)

        // Tính toán scale dựa trên khoảng cách từ trung tâm
        let maxDistance: CGFloat = 150
        let scaleFactor = max(1 - (distanceFromCenter / maxDistance), 0.5)

        return scaleFactor
    }
}

struct CircleScrollViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

#Preview {
    CircleScrollView()
}
