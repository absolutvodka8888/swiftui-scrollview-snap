//
//  ScrollViewSnapView.swift
//  ScrollViewOffset
//
//  Created by dongnguyen on 29/8/24.
//

import SwiftUI

struct ScrollViewSnapView: View {
    var body: some View {
        Text("Scroll View Snap")
        // Snap
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0 ..< 10) { i in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(hue: Double(i) / 10, saturation: 1, brightness: 1).gradient)
                        .frame(width: 300, height: 100)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, 40)
    }
}

#Preview {
    ScrollViewSnapView()
}
