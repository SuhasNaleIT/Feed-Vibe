// +--- Firebase Authentication
// |    +--- Users
// |         +--- userId (document ID)
// |              +--- username
// |              +--- email
// |
// +--- Firestore
// |    +--- users (collection)
// |         +--- userId (document ID)
// |              +--- username
// |              +--- email
// |
// |    +--- posts (collection)
// |         +--- postId (document ID)
// |              +--- userId
// |              +--- content
// |              +--- timestamp
// |              +--- likes
// |              +--- likedBy (array of userId)
// |
// +--- comments (subcollection)
// |                   +--- commentId (document ID)
// |                        +--- userId
// |                        +--- content
// |                        +--- timestamp