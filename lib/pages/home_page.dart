import 'package:crypto_app/blocs/crypto/crypto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto App"),
        centerTitle: false,
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Theme.of(context).primaryColor, Colors.black],
        )),
        child: BlocBuilder<CryptoBloc, CryptoState>(builder: (context, state) {
          switch (state.status) {
            case Status.loaded:
              return RefreshIndicator(
                color: Theme.of(context).colorScheme.secondary,
                onRefresh: (() async {
                  context.read<CryptoBloc>().add(RefreshCoins());
                }),
                child: ListView.builder(
                  itemCount: state.coins.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final coin = state.coins[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            coin.fullName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            coin.name,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Text(
                            '\$${coin.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  },
                ),
              );

            case Status.error:
              return Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.red, fontSize: 18.0),
                ),
              );

            default:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
              );
          }
        }),
      ),
    );
  }
}
