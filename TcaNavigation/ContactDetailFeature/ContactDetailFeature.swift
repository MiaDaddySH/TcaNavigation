//
//  ContactDetailFeature.swift
//  TcaNavigation
//
//  Created by Yuangang Sheng on 01.04.24.
//

import ComposableArchitecture

@Reducer
struct ContactDetailFeature {
  @ObservableState
  struct State: Equatable {
    let contact: Contact
  }

  enum Action {}

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {}
    }
  }
}
