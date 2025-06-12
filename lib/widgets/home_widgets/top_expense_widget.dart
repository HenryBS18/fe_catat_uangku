part of '../widgets.dart';

class TopExpenseWidget extends StatelessWidget {
  const TopExpenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return BlocBuilder<TopExpenseBloc, TopExpenseState>(
      builder: (context, state) {
        if (state is TopExpenseLoading) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is TopExpenseError) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('❌ ${state.message}'),
            ),
          );
        } else if (state is TopExpenseLoaded) {
          final data = state.data;
          final max = data
              .map((e) => e.total)
              .fold<double>(0.0, (a, b) => a > b ? a : b);

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
                      Text('Pengeluaran teratas',
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
                  const SizedBox(height: 8),
                  ...data.map((item) {
                    final ratio = max == 0 ? 0.0 : item.total / max;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.category,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(currency.format(item.total),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: ratio,
                              minHeight: 12,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ratio >= 0.9
                                      ? Colors.green
                                      : Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          context.read<TopExpenseBloc>().add(LoadTopExpense()),
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
