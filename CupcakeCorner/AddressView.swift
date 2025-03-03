//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by David Ferreira on 03/03/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form{
            Section {
                TextField("Name", text: $order.address.name)
                TextField("Stree Address", text: $order.address.streetName)
                TextField("City", text: $order.address.city)
                TextField("Zip", text: $order.address.zip)
            }
            
            Section {
                NavigationLink ("Checkout") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.address.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
