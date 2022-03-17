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
        ZStack {
            VStack (alignment: .center, spacing: SpacingValues.base01) {
                Spacer().frame(height: SpacingValues.base01)
                Text("Random Quote").font(.title)
                Spacer().frame(height: 32)
                Text(viewModel.content ?? "").onAppear(perform: fetch)
                    .font(.system(size: 24, weight: .regular, design: .default))
                    .multilineTextAlignment(.leading)
                    .padding(SpacingValues.base01)
                HStack(alignment: .center) {
                    Text(viewModel.characterFullName ?? "").onAppear(perform: fetch)
                        .font(.system(size: SpacingValues.base01, weight: .medium, design: .default))
                        .padding(SpacingValues.base01)
                    Spacer()
                }
                Spacer()
                Button("Get a new quote", action: fetch)
                    .padding(SpacingValues.base01)
            }.onAppear(perform: fetch)
            if viewModel.isLoading {
                LoadingSwiftUIView()
            }
        }
    }
    
    func fetch() {
        viewModel.loadRandomQuote()
    }
}

struct RandomQuoteSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let view = RandomQuoteSwiftUIView(viewModel: RandomQuoteViewModel())
        return view
    }
}
