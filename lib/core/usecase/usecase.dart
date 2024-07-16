/// Use this class as an interface when implementaing usecase
/// with return type [Type]
// ignore: one_member_abstracts
abstract class Usecase<Type, Params> {
  /// Method implementation
  Type call(Params params);
}
