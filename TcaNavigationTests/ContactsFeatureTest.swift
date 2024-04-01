//
//  ContactsFeatureTest.swift
//  TcaNavigationTests
//
//  Created by Yuangang Sheng on 01.04.24.
//

import ComposableArchitecture
import XCTest

@testable import TcaNavigation

@MainActor
final class ContactsFeatureTests: XCTestCase {
  func testAddFlow() async {
    let store = TestStore(initialState: ContactsFeature.State()) {
      ContactsFeature()
    } withDependencies: {
      $0.uuid = .incrementing
    }

    await store.send(.addButtonTapped) {
      $0.destination = .addContact(
        AddContactFeature.State(
          contact: Contact(id: UUID(0), name: "")
        )
      )
    }

    await store.send(\.destination.addContact.setName, "Blob Jr.") {
      $0.destination?.addContact?.contact.name = "Blob Jr."
    }

    await store.send(\.destination.addContact.saveButtonTapped)
    await store.receive(
      \.destination.addContact.delegate.saveContact,
      Contact(id: UUID(0), name: "Blob Jr.")
    ) {
      $0.contacts = [
        Contact(id: UUID(0), name: "Blob Jr.")
      ]
    }
    
    await store.receive(\.destination.dismiss) {
      $0.destination = nil
    }
  }
  
  func testAddFlow_NonExhaustive() async {
    let store = TestStore(initialState: ContactsFeature.State()) {
      ContactsFeature()
    } withDependencies: {
      $0.uuid = .incrementing
    }
    
    store.exhaustivity = .off
    
    await store.send(.addButtonTapped)
    
    await store.send(\.destination.addContact.setName, "Blob Jr.")
    
    await store.send(\.destination.addContact.saveButtonTapped)
    
    await store.skipReceivedActions()
    
    store.assert {
      $0.contacts = [
        Contact(id: UUID(0), name: "Blob Jr.")
      ]
      $0.destination = nil
    }
  }
}
