part of '../widgets.dart';

class BudgetWidget extends StatelessWidget {
  const BudgetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        if (state is BudgetLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BudgetError) {
          return Text('❌ ${state.message}');
        } else if (state is BudgetLoaded) {
          final data = state.budgets;

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
                      Text('Anggaran',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 8),
                  ...data.map((b) {
                    Color progressColor;
                    if (b.percentUsed < 75) {
                      progressColor = Colors.green;
                    } else if (b.percentUsed < 100) {
                      progressColor = Colors.orange;
                    } else {
                      progressColor = Colors.red;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(b.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  '${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(b.usedAmount)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text('${b.percentUsed.toStringAsFixed(0)}%'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              minHeight: 10,
                              value: b.percentUsed.clamp(0, 100) / 100,
                              backgroundColor: Colors.grey.shade200,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(progressColor),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(width: 12, height: 12, color: Colors.green),
                          const SizedBox(width: 4),
                          const Text('Dalam batasan',
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: 12, height: 12, color: Colors.orange),
                          const SizedBox(width: 4),
                          const Text('Risiko melebihi anggaran',
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 12, height: 12, color: Colors.red),
                          const SizedBox(width: 4),
                          const Text('Kelebihan pengeluaran',
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
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
