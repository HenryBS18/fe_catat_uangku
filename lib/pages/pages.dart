import 'dart:async';

import 'package:fe_catat_uangku/bloc/payment_planning_bloc/payment_planning_bloc.dart';
import 'package:fe_catat_uangku/bloc/user_bloc/user_bloc.dart';
import 'package:fe_catat_uangku/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:fe_catat_uangku/models/note.dart';
import 'package:fe_catat_uangku/models/user.dart';
import 'package:fe_catat_uangku/models/wallet.dart';
import 'package:fe_catat_uangku/services/user_service.dart';
import 'package:fe_catat_uangku/utils/custom_colors.dart';
import 'package:fe_catat_uangku/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fe_catat_uangku/bloc/note_bloc/note_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'main_page.dart';
part 'splashscreen_page.dart';
part 'home_page.dart';
part 'login_page.dart';
part 'register_page.dart';
part 'planning_page.dart';
part 'payment_planning_page.dart';
part 'budget_planning_page.dart';
part 'payment_planning_detail_page.dart';
part 'transaction_history_page.dart';
part 'web_view_page.dart';

part '../widgets/hold_action_fab.dart';
part 'profile_page.dart';
part 'add_payment_planning_page.dart';
