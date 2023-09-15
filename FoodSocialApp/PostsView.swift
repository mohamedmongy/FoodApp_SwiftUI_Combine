//
//  PostsView.swift
//  FoodSocialApp
//
//  Created by Mongy on 15/09/2023.
//

import SwiftUI


struct PostsView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            List {
                PostView()
                PostView()
                PostView()
                PostView()
                PostView()
            }
            .navigationBarBackButtonHidden()
            .searchable(text: $searchText)
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
