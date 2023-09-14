//
//  ContentView.swift
//  FoodSocialApp
//
//  Created by Mongy on 14/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView(viewModel: LogInViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
