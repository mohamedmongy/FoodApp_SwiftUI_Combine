//
//  PostInfoView.swift
//  FoodSocialApp
//
//  Created by Mongy on 15/09/2023.
//

import SwiftUI

struct PostInfoView: View {
    var body: some View {
        VStack {
            Text("this is a good receipe for making x using y and z this is a good receipe for making x using y and z this is a good receipe for making x using y and z")
            
            HStack(alignment: .top) {
                VStack {
                    postImage
                    postImage
                }
                VStack {
                    postImage
                    postImage
                }
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    @ViewBuilder var postImage: some View {
        Image("login-view-img")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct PostInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PostInfoView()
    }
}
