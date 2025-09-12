//
//  ContactsFeature.swift
//  ContactsAppTCA
//
//  Created by Andrew Stoddart on 9/12/25.
//

import ComposableArchitecture
import SwiftUI

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    @ObservableState
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    enum Action {
        case addButtonTapped
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                return .none
            }
        }
    }
}

struct ContactsView: View {
    let store: StoreOf<ContactsFeature>

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    Text(contact.name)
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
}

#Preview {
    ContactsView(
        store: Store(initialState: ContactsFeature.State(
            contacts: [
                Contact(id: UUID(), name: "Pat"),
                Contact(id: UUID(), name: "Michael"),
                Contact(id: UUID(), name: "Fred")
            ]
        )) {

            ContactsFeature()
    }
)
}
