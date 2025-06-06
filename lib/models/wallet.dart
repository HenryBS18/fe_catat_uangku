class WalletModel {
  final String id;
  final String name;
  final int balance;
  final DateTime createdAt;

  WalletModel(
      {required this.id,
      required this.name,
      required this.balance,
      required this.createdAt});
}
