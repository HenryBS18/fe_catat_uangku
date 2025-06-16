part of 'widgets.dart';

class PaymentPlanningItem extends StatefulWidget {
  final PaymentPlanning paymentPlanning;

  const PaymentPlanningItem({Key? key, required this.paymentPlanning}) : super(key: key);

  @override
  _PaymentPlanningItemState createState() => _PaymentPlanningItemState();
}

class _PaymentPlanningItemState extends State<PaymentPlanningItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PaymentPlanningDetailBloc>().add(SetPaymentPlanningDetailEvent(paymentPlanning: widget.paymentPlanning));
        Navigator.pushNamed(context, '/payment-planning-detail-page');
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border(bottom: BorderSide())),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.live_tv, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.paymentPlanning.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    if (widget.paymentPlanning.description.isNotEmpty)
                      Text(
                        widget.paymentPlanning.description,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    Text(
                      'Setiap ${widget.paymentPlanning.frequency} pada tanggal ${DateFormat('dd').format(widget.paymentPlanning.paymentDate)}',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      widget.paymentPlanning.walletId ?? '',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '-Rp ${widget.paymentPlanning.amount}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  DateFormat('dd MMMM', 'id_ID').format(widget.paymentPlanning.paymentDate),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
