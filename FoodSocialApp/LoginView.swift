//
//  LoginView.swift
//  FoodSocialApp
//
//  Created by Mongy on 14/09/2023.
//

import SwiftUI
import Combine

@MainActor
class LogInViewModel: ObservableObject {
    @Published var error: Error?
    @Published var showAlert: Bool = false
    
    func login(
        username: String,
        password: String
    ) async throws {
        do {
            try await NetWork.shared.request(
                route: LoginEndPoint.login(
                    input: LoginCredentials(
                        name:  username, //"kminchelle",
                        password: password //"0lelplR"
                    )
                ),
                T: UserResponseDModel.self
            )
        } catch(let error) {
            self.error = error
            self.showAlert = true
        }
    }
}

@MainActor
struct LoginView: View {
    @StateObject var viewModel: LogInViewModel
    @State var userName: String = ""
    @State var userPassword: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Image("login-view-img")
                    .resizable()
                
                Text("Welcome")
                    .foregroundColor(Color.blue)
                
                TextField("enter user name", text: $userName)
                
                SecureField("enter your password", text: $userPassword)
                
                Button("Sign in") {
                    Task {
                        try await viewModel.login(
                            username: userName,
                            password: userPassword
                        )
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 40)
                .foregroundColor(Color.white)
                .background(content: {
                    Color.blue
                })
                .cornerRadius(20)
            }
            .padding()
            .alert(
                viewModel.error?.localizedDescription ?? "Error",
                isPresented: $viewModel.showAlert) {
                    Button("Okay") {
                        viewModel.showAlert = false
                        viewModel.error = nil
                    }
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LogInViewModel())
    }
}
