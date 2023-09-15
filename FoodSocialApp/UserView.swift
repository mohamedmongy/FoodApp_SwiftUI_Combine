//
//  UserView.swift
//  FoodSocialApp
//
//  Created by Mongy on 15/09/2023.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                            
            VStack(alignment: .leading) {
                Text("mohamed mongy")
                Text("egypt")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.trailing)
        .padding(.leading)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
