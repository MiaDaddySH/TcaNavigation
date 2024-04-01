//
//  ContactDetailView.swift
//  TcaNavigation
//
//  Created by Yuangang Sheng on 01.04.24.
//

import ComposableArchitecture
import SwiftUI

struct ContactDetailView: View {
  let store: StoreOf<ContactDetailFeature>

  var body: some View {
    Form {}
      .navigationBarTitle(Text(store.contact.name))
  }
}

#Preview {
  NavigationStack {
    ContactDetailView(
      store: Store(
        initialState: ContactDetailFeature.State(
          contact: Contact(id: UUID(), name: "Blob")
        )
      ) {
        ContactDetailFeature()
      }
    )
  }
}
