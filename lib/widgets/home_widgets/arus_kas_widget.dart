part of '../widgets.dart';

class ArusKasWidget extends StatelessWidget {
  const ArusKasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return BlocBuilder<ArusKasBloc, ArusKasState>(
      builder: (context, state) {
        if (state is ArusKasLoading) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is ArusKasError) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('❌ ${state.message}'),
            ),
          );
        } else if (state is ArusKasLoaded) {
          final data = state.data;
          final isMinus = data.netCashflow < 0;
          final income = data.income;
          final expense = data.expense;

          final barRatio =
              income + expense == 0 ? 0.5 : income / (income + expense);

          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Arus Kas',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                      const Icon(Icons.more_horiz)
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text('BULAN INI',
                      style: Theme.of(context).textTheme.labelSmall),
                  Text(
                    '${isMinus ? '-' : ''}${currency.format(data.netCashflow.abs())}',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isMinus ? Colors.red : Colors.green),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pemasukan'),
                      Text(currency.format(income))
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: barRatio,
                      minHeight: 12,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pengeluaran'),
                      Text(currency.format(expense))
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 1.0,
                      minHeight: 12,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          context.read<ArusKasBloc>().add(LoadArusKas()),
                      child: const Text('Tampilkan lagi'),
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
