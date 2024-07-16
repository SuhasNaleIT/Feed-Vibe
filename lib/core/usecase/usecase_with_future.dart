/// Use this class as an interface when implementaing usecase
/// with return type [Future]
// ignore: one_member_abstracts
abstract class UsecaseWithFuture<Type, Params> {
  /// Method implementation
  Future<Type> call(Params params);
}
