part of '../widgets.dart';

class WalletTrendChart extends StatelessWidget {
  const WalletTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    final currency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tren Saldo',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            BlocBuilder<WalletTrendBloc, WalletTrendState>(
              builder: (context, state) {
                if (state is WalletTrendLoaded) {
                  return Text(currency.format(state.currentBalance),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold));
                } else {
                  return const SizedBox(height: 32);
                }
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BlocBuilder<WalletTrendBloc, WalletTrendState>(
                builder: (context, state) {
                  if (state is WalletTrendLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WalletTrendError) {
                    return Center(child: Text(state.message));
                  } else if (state is WalletTrendLoaded) {
                    final raw = state.trend;
                    if (raw.isEmpty) {
                      return const Center(child: Text('Tidak ada data'));
                    }

                    final fullList = raw.map((e) {
                      final date = DateTime.parse(e['date']);
                      final balance = (e['balance'] as num).toDouble();
                      return (date: date, balance: balance);
                    }).toList();

                    fullList.sort((a, b) => a.date.compareTo(b.date));

                    final spots = fullList
                        .asMap()
                        .entries
                        .map((e) => FlSpot(
                            e.key.toDouble(), e.value.balance.toDouble()))
                        .toList();

                    final maxY = fullList
                            .map((e) => e.balance)
                            .reduce((a, b) => a > b ? a : b) *
                        1.1;

                    return LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: (fullList.length - 1).toDouble(),
                        minY: 0,
                        maxY: maxY,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: maxY / 4,
                          getDrawingHorizontalLine: (_) => FlLine(
                              color: Colors.grey.withOpacity(0.3),
                              dashArray: [4, 4]),
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1.0,
                              getTitlesWidget: (v, meta) {
                                final idx = v.toInt();
                                if (idx < 0 || idx >= fullList.length) {
                                  return const SizedBox();
                                }
                                final dt = fullList[idx].date;
                                return SideTitleWidget(
                                  space: 4,
                                  meta: meta,
                                  child: Text('${dt.day}/${dt.month}',
                                      style: const TextStyle(fontSize: 10)),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 50,
                              interval: maxY / 4,
                              getTitlesWidget: (v, _) => Text(
                                  '${(v / 1000000).toStringAsFixed(1)}M',
                                  style: const TextStyle(fontSize: 10)),
                            ),
                          ),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipColor: (_) => Colors.white,
                            tooltipBorderRadius: BorderRadius.circular(5),
                            tooltipBorder: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 1,
                            ),
                            fitInsideHorizontally: true,
                            fitInsideVertically: true,
                            getTooltipItems: (spots) {
                              return spots.map((s) {
                                return LineTooltipItem(
                                  currency.format(s.y),
                                  const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            barWidth: 2,
                            color: Theme.of(context).primaryColor,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                            ),
                            dotData: FlDotData(show: false),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                    width: 12,
                    height: 12,
                    color: Theme.of(context).primaryColor),
                const SizedBox(width: 6),
                const Text('Tren Saldo', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
