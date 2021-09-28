import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/bloc/home/support/support_bloc.dart';
import 'package:water/main.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/email.dart';
import 'package:water/ui/validators/field.dart';
import 'package:water/util/session.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _credentialsFormKey = GlobalKey();
  final GlobalKey<FormState> _messageFormKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<SupportBloc, SupportState>(
        listener: (context, state) {
          print(state);
          context.showLoader(state.status == MessageStatus.sending);

          if (state.status == MessageStatus.sent) {
            _showToast(context, 'toast.message_sent'.tr());
            _messageController.clear();
          } else if (state.status == MessageStatus.failed) {
            showWaterDialog(context, ErrorAlert());
          }
        },
        child: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      title: WaterText(
        'screen.support'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          homeNavigator.pop();
        },
      ),
      actions: [
        AppBarIconButton(
          onPressed: () {},
          icon: AppIcons.whatsapp,
        ),
        if (Session.isAuthenticated) AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      physics: const BouncingScrollPhysics(),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: isMobile ? 100.w : 50.w,
          child: Column(
            children: [
              _buildCredentialsForm(context),
              const SizedBox(height: 24.0),
              _buildMessageForm(),
              const SizedBox(height: 24.0),
              _buildSendButton(context),
              const SizedBox(height: 16.0),
              _buildCallButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCredentialsForm(BuildContext context) {
    final profile = context.profile.state;
    final firstName = profile.firstName ?? '';
    final lastName = profile.lastName ?? '';
    _nameController.text = '$firstName $lastName'.trim();
    _emailController.text = profile.email ?? '';
    _phoneController.text = profile.phoneNumber ?? '';

    return Form(
      key: _credentialsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WaterText(
            'text.your_credentials'.tr(),
            fontSize: 18.0,
            lineHeight: 1.75,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ).withPadding(24.0, 0.0, 0.0, 0.0),
          const SizedBox(height: 24.0),
          WaterFormInput(
            controller: _nameController,
            hintText: 'input.your_name'.tr(),
            keyboardType: TextInputType.text,
            validator: const FieldValidator(fieldName: 'Name').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _emailController,
            hintText: 'input.your_email'.tr(),
            keyboardType: TextInputType.text,
            validator: const EmailValidator().validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _phoneController,
            hintText: 'input.your_phone'.tr(),
            keyboardType: TextInputType.text,
            validator: const FieldValidator(fieldName: 'Phone').validator,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageForm() {
    return Form(
      key: _messageFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WaterText(
            'text.type_your_message'.tr(),
            fontSize: 18.0,
            lineHeight: 1.75,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ).withPadding(24.0, 0.0, 0.0, 0.0),
          const SizedBox(height: 24.0),
          WaterFormInput(
            controller: _messageController,
            hintText: 'input.your_message'.tr(),
            keyboardType: TextInputType.multiline,
            validator: const FieldValidator(fieldName: 'Message').validator,
            autovalidateMode: AutovalidateMode.disabled,
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        FocusScope.of(context).unfocus();

        if (!_credentialsFormKey.currentState!.validate()) {
          return;
        }

        if (!_messageFormKey.currentState!.validate()) {
          return;
        }

        final name = _nameController.text;
        final email = _emailController.text;
        final phone = _phoneController.text;
        final message = _messageController.text;

        context.support.add(
          SendMessage(
            name: name,
            email: email,
            phone: phone,
            message: message,
          ),
        );
      },
      text: 'button.send'.tr(),
    );
  }

  Widget _buildCallButton() {
    return WaterSecondaryButton(
      onPressed: () {},
      text: 'button.click_to_call'.tr(),
      radialRadius: 3.0,
    );
  }

  void _showToast(BuildContext context, String message) {
    return ToastBuilder.of(context).showToast(
      child: Container(
        height: 64.0,
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.fromBorderSide(defaultBorder),
          borderRadius: BorderRadius.circular(19.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.15),
              spreadRadius: 0.0,
              blurRadius: 6.0,
              offset: const Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Center(
          child: WaterText(
            message,
            fontSize: 18.0,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
    );
  }
}
