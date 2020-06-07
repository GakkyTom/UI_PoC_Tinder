//
//  CardView.swift
//  TinderUIPoC
//
//  Created by 板垣智也 on 2020/06/06.
//  Copyright © 2020 板垣智也. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: LikeDislike = .none

    private var kitten: Kitten
    private var onRemove: (_ kitten: Kitten) -> Void

    private var thresholdPercentage: CGFloat = 0.5 // when the user has dragged 50% the width of the screen in either direction

    private enum LikeDislike: Int {
        case like, dislike, none
    }

    init(kitten: Kitten, onRemove: @escaping (_ kitten: Kitten) -> Void) {
        self.kitten = kitten
        self.onRemove = onRemove
    }

    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ZStack(alignment: self.swipeStatus == .like ? .topLeading : .topTrailing) {
                    Image(self.kitten.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                        .clipped()

                    if self.swipeStatus == .like {
                        Text("LIKE")
                            .font(.headline)
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(Color.green)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 3.0)
                        ).padding(24)
                            .rotationEffect(Angle.degrees(-45))
                    } else if self.swipeStatus == .dislike {
                        Text("DISLIKE")
                            .font(.headline)
                        .padding()
                        .cornerRadius(10)
                            .foregroundColor(Color.red)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 3.0)
                        ).padding(.top, 45)
                            .rotationEffect(Angle.degrees(45))
                    }
                }

                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(self.kitten.name), \(self.kitten.age)")
                            .font(.title)
                        .bold()
                        Text(self.kitten.occupation)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()

                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            // Add padding, corner radius and shadow with blur radius
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .animation(.interactiveSpring())    // Cardの戻りをなめらかにする
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation

                        if (self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                            self.swipeStatus = .like
                        } else if self.getGesturePercentage(geometry, from: value) <= -self.thresholdPercentage {
                            self.swipeStatus = .dislike
                        } else {
                            self.swipeStatus = .none
                        }
                    }.onEnded { value in
                        // determine snap distance > 0.5 aka half the widt of the screen
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.kitten)
                        } else {
                            self.translation = .zero
                        }
                }
            )
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(kitten: Kitten(id: 1, name: "Mark", age: 1, mutualFriends: 0, imageName: "11", occupation: "house keeper"), onRemove: { _ in
            // do nothing
        })
        .frame(height: 400)
        .padding()
    }
}
