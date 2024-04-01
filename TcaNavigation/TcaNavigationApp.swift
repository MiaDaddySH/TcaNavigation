//
//  TcaNavigationApp.swift
//  TcaNavigation
//
//  Created by Yuangang Sheng on 31.03.24.
//

import ComposableArchitecture
import SwiftUI

@main
struct TcaNavigationApp: App {
  var body: some Scene {
    WindowGroup {
      ContactsView(
        store: Store(initialState: ContactsFeature.State()) {
          ContactsFeature()
        }
      )
    }
  }
}
