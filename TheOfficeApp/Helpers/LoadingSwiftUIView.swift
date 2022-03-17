//
//  LoadingSwiftUIView.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 26/12/21.
//

import SwiftUI

struct LoadingSwiftUIView: View {
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.5)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(2)
        }
    }
}

struct LoadingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSwiftUIView()
    }
}
