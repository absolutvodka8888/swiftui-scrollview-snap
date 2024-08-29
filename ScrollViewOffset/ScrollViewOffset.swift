//
//  ScrollViewOffset.swift
//  ScrollViewOffset
//
//  Created by dongnguyen on 29/8/24.
//

import SwiftUI

struct ScrollViewOffset: View {
    let numberOfSquares = 50 // Số lượng ô vuông
    @State private var offset = CGFloat.zero
    var body: some View {
        VStack {
            Text("Scroll View offset \(offset)")
            // Offset
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< numberOfSquares, id: \.self) { _ in
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 90, height: 90)
                    }
                }
                .background(GeometryReader { geo in
                    Color.clear.preference(key: ScrollViewOffsetKey.self, value: -geo.frame(in: .named("scroll")).origin.x)
                })
                .onPreferenceChange(ScrollViewOffsetKey.self) {
                    print("offset >> \($0)")
                    offset = $0
                }
            }.coordinateSpace(name: "scroll")
        }
    }
}

#Preview {
    ScrollViewOffset()
}

// Scroll view offset
struct ScrollViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
