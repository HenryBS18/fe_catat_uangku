import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fe_catat_uangku/bloc/arus_kas_bloc/arus_kas_bloc.dart';
import 'package:fe_catat_uangku/bloc/bloc/note_by_wallet_bloc.dart';
import 'package:fe_catat_uangku/bloc/budget_bloc/budget_bloc.dart';
import 'package:fe_catat_uangku/bloc/note_bloc/note_bloc.dart';
import 'package:fe_catat_uangku/bloc/planned_payment_dash_bloc/payment_planned_dash_bloc.dart';
import 'package:fe_catat_uangku/bloc/top_expense_bloc/top_expense_bloc.dart';
import 'package:fe_catat_uangku/bloc/trend_saldo_bloc/trend_saldo_bloc.dart';
import 'package:fe_catat_uangku/bloc/user_bloc/user_bloc.dart';
import 'package:fe_catat_uangku/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:fe_catat_uangku/bloc/wallet_trend_bloc/wallet_trend_bloc.dart';
import 'package:fe_catat_uangku/models/note.dart';
import 'package:fe_catat_uangku/models/wallet.dart';
import 'package:fe_catat_uangku/pages/pages.dart';
import 'package:fe_catat_uangku/services/note_service.dart';
import 'package:fe_catat_uangku/services/wallet_service.dart';
import 'package:fe_catat_uangku/utils/capitalize_first_letter_formatter.dart';
import 'package:fe_catat_uangku/utils/custom_colors.dart';
import 'package:fe_catat_uangku/utils/custom_snackbar.dart';
import 'package:fe_catat_uangku/utils/thousands_separator_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:fl_chart/fl_chart.dart';

part 'dots_indicator.dart';

part 'modals/change_password_modal.dart';
part 'modals/notification_settings_modal.dart';
part 'modals/help_center_modal.dart';
part 'modals/term_condition_modal.dart';
part 'modals/privacy_policy_modal.dart';
part 'modals/wallet_selection_page.dart';
part 'modals/categories_selection_modal.dart';
part 'modals/notes_section_modal.dart';

part 'modals/voice_record_modal.dart';
part 'modals/add_note_modal.dart';
part 'modals/scan_modal.dart';
part 'modals/add_wallet_modal.dart';
part 'modals/edit_wallet_modal.dart';

part 'input/input.dart';
part 'input/input_password.dart';
part 'input/input_date.dart';
part 'input/input_text_area.dart';
part 'button.dart';
part 'loading.dart';
part 'error_dialog.dart';

part 'home_widgets/chart_tren_widget.dart';
part 'home_widgets/arus_kas_widget.dart';
part 'home_widgets/top_expense_widget.dart';
part 'home_widgets/planned_payment_dash_widget.dart';
part 'home_widgets/budgets_widget.dart';
part 'home_widgets/header_wallet_widget.dart';
part 'home_widgets/wallet_trend_chart.dart';
part 'home_widgets/wallet_transaction_history_widget.dart';
