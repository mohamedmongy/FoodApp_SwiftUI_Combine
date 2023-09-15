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
    @Published var userLoggedIn = false
    
    func login(
        username: String,
        password: String
    ) async throws {
        do {
          _ =  try await NetWork.shared.request(
                route: EndPoint.login(
                    input: LoginCredentials(
                        name: "kminchelle",
                        password: "0lelplR"
                    )
                ),
                T: UserResponseDModel.self
            )
            
            userLoggedIn = true
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
    @EnvironmentObject var appRoute: PathManager
    
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
            .onChange(of: viewModel.userLoggedIn, perform: { newValue in
                appRoute.path.append(AppRoute.homeFeedView)
            })
            
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
