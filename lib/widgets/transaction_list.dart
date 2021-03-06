import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints){
          return Column(
            children: [
              Text(
                'No Transactions added yet',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
    })

        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 6,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 6,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: mediaQuery.size.width >460 ? FlatButton.icon(
                    textColor: Theme.of(context).errorColor,
                      onPressed: ()=> deleteTx(transactions[index].id),
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                  ) :IconButton(
                    icon: Icon(Icons.delete), onPressed: () => deleteTx(transactions[index].id),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );

            },
            itemCount: transactions.length,
          );
  }
}
