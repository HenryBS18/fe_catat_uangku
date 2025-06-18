part of 'pages.dart';

class AddPaymentPlanningPage extends StatefulWidget {
  const AddPaymentPlanningPage({Key? key}) : super(key: key);

  @override
  _AddPaymentPlanningPageState createState() => _AddPaymentPlanningPageState();
}

class _AddPaymentPlanningPageState extends State<AddPaymentPlanningPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  List<CustomDropdownModel> wallets = [];
  List<String> frequencies = ['monthly'];
  List<String> categories = ['makanan', 'hiburan'];

  CustomDropdownModel? selectedWallet;
  String? selectedFrequency;
  String? selectedCategory;

  bool isLoading = false;

  void getWallets() async {
    List<WalletModel> walletsRaw = await WalletService().getWallets();

    setState(() {
      wallets = walletsRaw.map((e) => CustomDropdownModel(label: e.name, value: e.id)).toList();
    });
  }

  void add() async {
    setState(() {
      isLoading = true;
    });
    try {
      final PaymentPlanningService paymentPlanningService = PaymentPlanningService();

      final bool isSuccess = await paymentPlanningService.addNew(PaymentPlanning(
        walletId: selectedWallet!.value,
        title: titleController.text,
        description: descriptionController.text,
        category: selectedCategory!,
        amount: int.parse(amountController.text),
        paymentDate: DateFormat('dd/MM/yyyy').parse(dateController.text),
        frequency: selectedFrequency!,
        type: 'expense',
      ));

      if (isSuccess) {
        context.read<PaymentPlanningBloc>().add(GetPaymentPlanningListEvent());
        Navigator.pop(context);
      }
    } catch (e) {
      errorDialog(context, e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getWallets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Rencana Pembayaran'),
      ),
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Input(
                                label: 'Judul',
                                controller: titleController,
                              ),
                              const SizedBox(height: 8),
                              Input(
                                label: 'Jumlah',
                                type: TextInputType.number,
                                controller: amountController,
                              ),
                              const SizedBox(height: 8),
                              CustomDropdown(
                                label: 'Dompet',
                                hint: 'Pilih dompet',
                                items: wallets,
                                selectedItem: selectedWallet,
                                onChanged: (value) {
                                  setState(() {
                                    selectedWallet = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 8),
                              InputTextArea(
                                label: 'Deskripsi',
                                maxLines: 3,
                                controller: descriptionController,
                              ),
                              const SizedBox(height: 8),
                              CustomDropdown(
                                label: 'Kategori',
                                hint: 'Pilih kategori',
                                items: categories,
                                selectedItem: selectedCategory,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 8),
                              InputDate(label: 'Tanggal', controller: dateController, iconOn: false),
                              const SizedBox(height: 8),
                              CustomDropdown(
                                label: 'Frekuensi',
                                hint: 'Pilih frekuensi',
                                items: frequencies,
                                selectedItem: selectedFrequency,
                                onChanged: (value) {
                                  setState(() {
                                    selectedFrequency = value;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Button(title: 'Simpan', onTap: add),
                  ),
                ],
              ),
            ),
            if (isLoading) Loading(message: 'Sedang menambahkan rencana pembayaran'),
          ],
        ),
      ),
    );
  }
}
