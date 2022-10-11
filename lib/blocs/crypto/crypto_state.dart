part of 'crypto_bloc.dart';


enum Status { initial, loading, loaded, error }

class CryptoState extends Equatable {
  final List<CryptoCurrency> coins;
  final Status status;

  const CryptoState({
    required this.coins,
    required this.status,
  });

  factory CryptoState.start() => const CryptoState(
    coins: [],
    status: Status.initial,
  );

  @override
  List<Object> get props => [coins, status];

  CryptoState copyWith({
    List<CryptoCurrency>? coins,
    Status? status,
  }) {
    return CryptoState(
      coins: coins ?? this.coins,
      status: status ?? this.status,
    );
  }
}
