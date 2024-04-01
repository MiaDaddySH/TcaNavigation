//
//  ContactsFeature.swift
//  TcaNavigation
//
//  Created by Yuangang Sheng on 31.03.24.
//

import ComposableArchitecture
import Foundation

struct Contact: Equatable, Identifiable {
  let id: UUID
  var name: String
}

@Reducer
struct ContactsFeature {
  @ObservableState
  struct State: Equatable {
    var contacts: IdentifiedArrayOf<Contact> = []
    @Presents var addContact: AddContactFeature.State?
    @Presents var alert: AlertState<Action.Alert>?
  }

  enum Action {
    case addButtonTapped
    case addContact(PresentationAction<AddContactFeature.Action>)
    case alert(PresentationAction<Alert>)
    case deleteButtonTapped(id: Contact.ID)

    enum Alert: Equatable {
      case confirmDeletion(id: Contact.ID)
    }
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.addContact = AddContactFeature.State(contact: .init(id: UUID(), name: ""))
        return .none

      case let .addContact(.presented(.delegate(.saveContact(contact)))):
        state.contacts.append(contact)
        return .none

      case .addContact:
        return .none

      case let .alert(.presented(.confirmDeletion(id: id))):
        state.contacts.remove(id: id)
        return .none

      case .alert:
        return .none

      case let .deleteButtonTapped(id: id):
        state.alert = AlertState {
          TextState("Are you sure?")
        } actions: {
          ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
            TextState("Delete")
          }
        }
        return .none
      }
    }
    .ifLet(\.$addContact, action: \.addContact) {
      AddContactFeature()
    }
    .ifLet(\.$alert, action: \.alert)
  }
}
