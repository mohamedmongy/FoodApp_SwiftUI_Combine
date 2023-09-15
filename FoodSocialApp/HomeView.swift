//
//  HomeView.swift
//  FoodSocialApp
//
//  Created by Mongy on 15/09/2023.
//

import SwiftUI

struct GetPostsResponseDModel: Codable {
    let posts: [PostDModel]
    let total, skip, limit: Int
}

// MARK: - Post
struct PostDModel: Codable {
    let id: Int
    let title, body: String
    let userID: Int
    let tags: [String]
    let reactions: Int

    enum CodingKeys: String, CodingKey {
        case id, title, body
        case userID = "userId"
        case tags, reactions
    }
}

@MainActor
class PostsViewModel: ObservableObject {
    @Published var error: Error?
    @Published var showAlert: Bool = false
    
    func getPosts(
        limit: Int,
        skip: Int
    ) async {
        do {
            let posts =  try await NetWork.shared.request(
                route: EndPoint.posts(
                    input: PostsInput(
                        limit: limit,
                        skip: skip
                    )
                ),
                T: GetPostsResponseDModel.self
            )
            print("posts: \(posts)")
        } catch(let error) {
            self.error = error
            self.showAlert = true
        }
    }
}

struct HomeView: View {
    
    @StateObject var viewModel = PostsViewModel()
    
    var body: some View {
        VStack {
           PostsView()
        }.onAppear {
            Task {
                 await viewModel.getPosts(limit: 10, skip: 0)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
