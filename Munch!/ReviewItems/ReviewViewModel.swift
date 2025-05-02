//
//  ReviewViewModel.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//
import SwiftUI

class ReviewViewModel: ObservableObject {
    @Published var rating: Int = 0
    @Published var reviewText: String = ""
    @Published var isSubmitting: Bool = false
    @Published var submissionSuccess: Bool?
    @Published var reviews: [Review] = []
        
    func submitReview(userId: Int, foodId: Int) {
        let reviewRequest = ReviewRequest(
            user_id: userId,
            food_id: foodId,
            rating: Float(rating),
            review: reviewText
        )

        isSubmitting = true
           
        NetworkManager.shared.postReview(review: reviewRequest) { [weak self] success in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.isSubmitting = false
                self.submissionSuccess = success
                
                if success {
                    self.reviewText = ""
                    self.rating = 0
                    self.fetchReviews(foodId: foodId)
                }
            }
        }
    }
    
    func fetchReviews(foodId: Int) {
        NetworkManager.shared.getReviewsForFood(foodId: foodId) { [weak self] reviews in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.reviews = reviews
            }
        }
    }
}
