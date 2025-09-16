//
//  AddContactsFeature.swift
//  ContactsAppTCA
//
//  Created by Andrew Stoddart on 9/12/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AddContactFeature {
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    enum Action {
        case cancelButtonTappped
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        enum Delegate: Equatable {
            case saveContact(Contact)
        }
    }
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTappped:
                return .run { _ in await self.dismiss() }

            case .delegate:
                return .none

            case .saveButtonTapped:
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }

            case .setName(let name):
                state.contact.name = name
                return .none
            }
        }
    }
}

struct AddContactView: View {
    @Bindable var store: StoreOf<AddContactFeature>

    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    store.send(.cancelButtonTappped)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddContactView(
            store: Store(
                initialState: AddContactFeature.State(
                    contact: Contact(id: UUID(), name: "Pat")
                )
            ) {
                AddContactFeature()
            }
        )
    }
}
