const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.updateProductRating = functions.firestore
    .document('all_reviews/{productId}/reviews/{reviewId}')
    .onWrite(async (change, context) => {
    const productId = context.params.productId;

    // Get all reviews for the selected product
    const reviewsSnapshot = await admin.firestore().collection('all_reviews').doc(productId).collection('reviews').get();

    let totalRating = 0;
    let numReviews = 0;

    reviewsSnapshot.forEach(doc => {
        const reviewData = doc.data();
        totalRating += reviewData.rating;
        numReviews++;
    });

    let averageRatingString;
    if (numReviews > 0) {
        const averageRating = totalRating / numReviews;
        averageRatingString = averageRating.toFixed(1); // Convert to string with 1 decimal place
    } else {
        // if no review for product, default average rating to 0
        averageRatingString = '0.0';
    }

    // Update the averageRating value in the products collection
    await admin.firestore().collection('products').doc(productId).update({
        averageRating: averageRatingString,
        totalReviews:numReviews
    });
});