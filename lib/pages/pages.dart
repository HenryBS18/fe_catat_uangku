import 'package:fe_catat_uangku/utils/custom_colors.dart';
import 'package:fe_catat_uangku/utils/thousands_separator_input_formatter.dart';
import 'package:fe_catat_uangku/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fe_catat_uangku/widgets/custom_elevated_button.dart';
import 'package:fe_catat_uangku/widgets/custom_text_form.dart';
import 'package:fe_catat_uangku/repositories/repository.dart';
import 'package:fe_catat_uangku/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fe_catat_uangku/services/api_services.dart';
import 'dart:async';
import 'dart:math';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

part 'main_page.dart';
part 'splashscreen_page.dart';
part 'home_page.dart';
part 'authpage.dart';
part 'planning_page.dart';
part 'payment_planning_page.dart';
part 'budget_planning_page.dart';
part 'payment_planning_detail_page.dart';

part '../widgets/hold_action_fab.dart';
part 'profile_page.dart';

// modal di profile
part '../widgets/modals/change_password_modal.dart';
part '../widgets/modals/notification_settings_modal.dart';
part '../widgets/modals/help_center_modal.dart';
part '../widgets/modals/term_condition_modal.dart';
part '../widgets/modals/privacy_policy_modal.dart';
part '../widgets/modals/wallet_selection_page.dart';
part '../widgets/modals/categories_selection_modal.dart';
part '../widgets/modals/notes_section_modal.dart';

//Modal untuk Transaction
part '../widgets/modals/add_transaction_modal.dart';
part '../widgets/modals/scan_modal.dart';
part '../widgets/modals/voice_record_modal.dart';
