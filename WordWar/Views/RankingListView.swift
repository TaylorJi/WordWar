//
//  RankingListView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-12-04.
//

import SwiftUI

struct RankingListView: View {
    var topScores: [(email: String, score: Int)]
    var body: some View {
            List(topScores.indices, id: \.self) { index in
                HStack {
                    Group {
                        if index == 0 {
                            Text("🥇")
                        } else if index == 1 {
                            Text("🥈")
                        } else if index == 2 {
                            Text("🥉")
                        } else {
                            Text("\(index + 1).")
                                .font(.system(size: 20))
                        }
                    }
                    .font(.system(size: 40))
                    
                    Text("\(topScores[index].email):")
                        .foregroundColor(.black)
                        .font(.headline)
                    Spacer()
                    Text("\(topScores[index].score)")
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .padding(.vertical)
            }
        }
}

//#Preview {
//    RankingListView()
//}
