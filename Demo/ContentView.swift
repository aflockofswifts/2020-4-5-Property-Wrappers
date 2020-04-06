//
//  ContentView.swift
//  Demo
//
//  Created by Joshua Homann on 4/3/20.
//  Copyright © 2020 com.josh. All rights reserved.
//

import SwiftUI
import Combine

final class Model: ObservableObject {
  @Published var color: UIColor = .black
  @Published var index: Int = 0
  var subscriptions = Set<AnyCancellable>()
  init() {
    let colors: [UIColor] = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)]

    $index
      .map { colors[$0] }
      .assign(to: \.color, on: self)
      .store(in: &subscriptions)
  }
}

struct BoundView: View {
  @Binding private var index: Int
  let colorNames = ["Red","Orange","Yellow","Green","Blue","Purple"]
  init(index: Binding<Int>) {
    _index = index
  }
  var body: some View {
    VStack {
      Button("Next") {
        self.index = self.index + 1 < self.colorNames.count ? self.index + 1 : 0
      }
      .font(.largeTitle)
      .foregroundColor(.white)
      Picker(selection: $index, label: EmptyView()) {
        ForEach (colorNames.indices) {
          Text(self.colorNames[$0])
        }
      }
      .pickerStyle(SegmentedPickerStyle())
    }
  }
}

struct ContentView: View {
  @ObservedObject var model = Model()
  var body: some View {
    Color(model.color)
      .overlay(BoundView(index: $model.index))
      .animation(.linear)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
