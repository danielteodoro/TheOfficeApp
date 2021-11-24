//
//  RandomQuoteSwiftUIView.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/21.
//

import SwiftUI

struct RandomQuoteSwiftUIView: View {
    @ObservedObject var viewModel: RandomQuoteViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            Text(viewModel.content ?? "").onAppear(perform: fetch)
                .padding(16)
                .font(.system(size: 24, weight: .regular, design: .default))
            HStack(alignment: .center) {
                Text(viewModel.characterFullName ?? "").onAppear(perform: fetch)
                    .padding(16)
                    .font(.system(size: 16, weight: .medium, design: .default))
                Spacer()
            }
        }.onAppear(perform: fetch)
    }
    
    func fetch() {
        viewModel.loadRandomQuote()
    }
}

struct RandomQuoteSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RandomQuoteSwiftUIView(viewModel: RandomQuoteViewModel())
    }
}