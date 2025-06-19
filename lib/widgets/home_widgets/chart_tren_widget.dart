part of '../widgets.dart';

class ChartTrenWidget extends StatefulWidget {
  const ChartTrenWidget({super.key});

  @override
  State<ChartTrenWidget> createState() => _ChartTrenWidgetState();
}

class _ChartTrenWidgetState extends State<ChartTrenWidget> {
  int dayRange = 7;

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
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                DropdownButton<int>(
                  value: dayRange,
                  items: const [
                    DropdownMenuItem(value: 7, child: Text('7 Hari')),
                    DropdownMenuItem(value: 30, child: Text('30 Hari')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => dayRange = val);
                    }
                  },
                  underline: const SizedBox(),
                  style: Theme.of(context).textTheme.bodyMedium,
                )
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
                    if (state.data.isEmpty) {
                      return const Center(child: Text('Tidak ada data'));
                    }

                    final now = DateTime.now();
                    final startDate =
                        now.subtract(Duration(days: dayRange - 1));
                    final dates = List.generate(
                        dayRange, (i) => startDate.add(Duration(days: i)));

                    final Map<String, double?> balanceByDate = {
                      for (var d in dates)
                        DateFormat('yyyy-MM-dd').format(d): null
                    };
                    for (var entry in state.data) {
                      final key = DateFormat('yyyy-MM-dd').format(entry.date);
                      if (balanceByDate.containsKey(key)) {
                        balanceByDate[key] = entry.balance;
                      }
                    }

                    double lastBalance = 0.0;
                    final fullList = dates.map((d) {
                      final key = DateFormat('yyyy-MM-dd').format(d);
                      final balance = balanceByDate[key] ?? lastBalance;
                      lastBalance = balance;
                      return (date: d, balance: balance);
                    }).toList();

                    final spots = fullList.asMap().entries.map((e) {
                      final value = e.value.balance;
                      return FlSpot(
                          e.key.toDouble(),
                          value <= 0 && e.key > 0
                              ? fullList[e.key - 1].balance
                              : value);
                    }).toList();

                    final maxY = (fullList
                            .map((e) => e.balance < 0 ? 0 : e.balance)
                            .reduce((a, b) => a > b ? a : b)) *
                        1.1;

                    return LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: (fullList.length - 1).toDouble(),
                        minY: 0,
                        maxY: maxY == 0 ? 100 : maxY,
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
                              interval: dayRange == 30 ? 5.0 : 1.0,
                              getTitlesWidget: (v, meta) {
                                final idx = v.toInt();
                                if (idx < 0 || idx >= fullList.length)
                                  return const SizedBox();
                                final dt = fullList[idx].date;
                                return Transform.rotate(
                                  angle: dayRange > 7 ? -1.0 : 0.0,
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
                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipColor: (spot) => Colors.white,
                            tooltipBorderRadius: BorderRadius.circular(5),
                            tooltipBorder: BorderSide(
                                color: Colors.black.withOpacity(0.1), width: 1),
                            fitInsideHorizontally: true,
                            fitInsideVertically: true,
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((touchedSpot) {
                                return LineTooltipItem(
                                    'Rp ${touchedSpot.y.toStringAsFixed(0)}',
                                    const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12));
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
