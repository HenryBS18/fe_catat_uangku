part of '../widgets.dart';

class ChartTrenWidget extends StatelessWidget {
  const ChartTrenWidget({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tren Saldo',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                const Icon(Icons.more_horiz)
              ],
            ),
            const SizedBox(height: 12),
            Text('HARI INI', style: Theme.of(context).textTheme.labelSmall),
            BlocBuilder<TrendSaldoBloc, TrendSaldoState>(
              builder: (context, state) {
                if (state is TrendSaldoLoaded) {
                  return Text(currency.format(state.total),
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
              child: BlocBuilder<TrendSaldoBloc, TrendSaldoState>(
                builder: (context, state) {
                  if (state is TrendSaldoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TrendSaldoError) {
                    return Center(child: Text(state.message));
                  } else if (state is TrendSaldoLoaded) {
                    final fullList = state.data;
                    final spots = fullList
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value.balance))
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
                                if (idx < 0 || idx >= fullList.length)
                                  return const SizedBox();
                                final dt = fullList[idx].date;
                                return SideTitleWidget(
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
                              interval: maxY / 4,
                              reservedSize: 50,
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
                                    .withOpacity(0.2)),
                            dotData: FlDotData(show: false),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: Text('Tidak ada data'));
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                TextButton(
                  onPressed: () =>
                      context.read<TrendSaldoBloc>().add(LoadTrendSaldo()),
                  child: const Text('Tampilkan lagi'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
