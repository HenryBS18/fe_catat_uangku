part of '../widgets.dart';

class PlannedPaymentDashWidget extends StatelessWidget {
  const PlannedPaymentDashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return BlocBuilder<PlannedPaymentDashBloc, PlannedPaymentState>(
      builder: (context, state) {
        if (state is PlannedPaymentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PlannedPaymentError) {
          return Text('❌ ${state.message}');
        } else if (state is PlannedPaymentLoaded) {
          final data = state.data;

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
                      Text('Rencana Pembayaran',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    final isIncome = item.type == 'income';
                    final amountColor = isIncome ? Colors.green : Colors.red;
                    final icon = isIncome ? Icons.payments : Icons.menu_book;
                    final iconColor = isIncome ? Colors.green : Colors.red;

                    final labelText = item.daysRemaining < 0
                        ? 'Terlambat ${item.daysRemaining}'
                        : item.daysRemaining == 0
                            ? 'Hari Ini'
                            : item.daysRemaining == 1
                                ? 'Besok'
                                : 'H-${item.daysRemaining}';

                    final labelColor = item.daysRemaining < 0
                        ? Colors.red
                        : (item.daysRemaining == 0 || item.daysRemaining == 1)
                            ? Colors.orange.shade800
                            : Colors.green.shade800;

                    final labelBackground = item.daysRemaining < 0
                        ? Colors.red.shade100
                        : (item.daysRemaining == 0 || item.daysRemaining == 1)
                            ? Colors.orange.shade100
                            : Colors.green.shade100;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: iconColor.withOpacity(0.2),
                                child: Icon(icon, color: iconColor),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Kiri
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item.title,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(item.category,
                                                style: const TextStyle(
                                                    color: Colors.black87)),
                                            Text(item.wallet,
                                                style: const TextStyle(
                                                    color: Colors.grey)),
                                            Text(item.description,
                                                style: const TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                        // Kanan
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${isIncome ? '' : '-'}${currency.format(item.amount)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: amountColor),
                                            ),
                                            const SizedBox(height: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: labelBackground,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                labelText,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: labelColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item.daysRemaining == 0
                                          ? 'Hari ini'
                                          : item.daysRemaining > 0
                                              ? 'Dalam ${item.daysRemaining} hari'
                                              : 'Terlambat ${item.daysRemaining.abs()} hari',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        if (index < data.length - 1)
                          const Divider(height: 24, color: Colors.grey),
                      ],
                    );
                  }).toList(),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () => context
                  //         .read<PlannedPaymentDashBloc>()
                  //         .add(LoadPlannedPayment()),
                  //     child: const Text('Tampilkan lagi'),
                  //   ),
                  // )
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
