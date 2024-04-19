//
//  ResultView.swift
//  EveryRandom
//
//  Created by KIBEOM SHIN on 4/18/24.
//

import SwiftUI

struct ResultView: View {
    @Binding var showResultView: Bool
    @Binding var animationCount: Bool
    let winner: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("축하합니다")
                .font(.headline)
            
            HStack(alignment: .center, spacing: 10) {
                Spacer()
                Image(systemName: "heart.fill")
                    .symbolEffect(.bounce.up.wholeSymbol, options: .repeat(10), value: animationCount)
                    .foregroundStyle(.pink)
                Text(winner)
                    .font(.title)
                    .bold()
                Image(systemName: "heart.fill")
                    .symbolEffect(.bounce.up.wholeSymbol, options: .repeat(10), value: animationCount)
                    .foregroundStyle(.pink)
                Spacer()
            }
            .font(.title2)
            .bold()
            .padding()
            
            Button {
                showResultView = false
            } label: {
                Text("확인")
                    .padding(.horizontal, 25)
                    .frame(height: 35)
                    .foregroundColor(.white)
                    .bold()
                    .background(.pink)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ResultView(showResultView: .constant(true), animationCount: .constant(true), winner: "신기범")
}
