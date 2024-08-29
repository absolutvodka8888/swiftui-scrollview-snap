//
//  ContentView.swift
//  ScrollViewOffset
//
//  Created by dongnguyen on 29/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ScrollViewOffset()
            ScrollViewSnapView()
            CircleScrollView()
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
