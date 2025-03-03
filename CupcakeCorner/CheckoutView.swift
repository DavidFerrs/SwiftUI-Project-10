//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by David Ferreira on 03/03/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingAlert = false
    @State private var showingErrorAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFill()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total order is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingAlert){} message: {
            Text(confirmationMessage)
        }
        .alert("Something went wrong", isPresented: $showingErrorAlert) {} message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpMethod = "POST"
        
        do {
            let (data, res) = try await URLSession.shared.upload(for: request, from: encoded)
            print(res)
            
            //handle response
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way"
            showingAlert = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            confirmationMessage = "We cannot process your order now"
            showingErrorAlert = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
