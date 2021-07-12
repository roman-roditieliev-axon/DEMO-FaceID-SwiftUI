//
//  MainView.swift
//  DEMO-FaceID_SwiftUI
//
//  Created by User on 09.07.2021.
//

import SwiftUI

struct MainView: View {

    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                self.iconImageView
                Text("Success authorization!")
            }.padding(.top, -200)
        }
    }

    var iconImageView: some View {
        Image(uiImage: UIImage(named: "success")!).resizable().frame(width: 150, height: 150)
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
