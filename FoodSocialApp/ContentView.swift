//
//  ContentView.swift
//  FoodSocialApp
//
//  Created by Mongy on 14/09/2023.
//

import SwiftUI

enum AppRoute: Identifiable {
    case homeFeedView
    
    var id: UUID {
        switch self {
        case .homeFeedView:
            return UUID()
        }
    }
}

class PathManager: ObservableObject {
    @Published var path = NavigationPath()
}

struct ContentView: View {
    @StateObject var pathManager = PathManager()
    
    var body: some View {
        NavigationStack(path: $pathManager.path) {
            LoginView(viewModel: LogInViewModel())
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .homeFeedView:
                    HomeView()
                }
            }
        }
        .environmentObject(pathManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



