import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/bloc/home/support/support_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/email.dart';
import 'package:water/ui/validators/field.dart';

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
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        child: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'screen.support'.tr(),
        fontSize: 24.0,
        maxLines: 2,
        lineHeight: 2.0,
        textAlign: TextAlign.center,
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
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocListener<SupportBloc, SupportState>(
      listener: (context, state) {
        context.showLoader(state.status == MessageStatus.sending);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          ).withPadding(24.0, 0.0, 0.0, 0.0),
          const SizedBox(height: 24.0),
          WaterFormInput(
            controller: _messageController,
            hintText: 'input.your_message'.tr(),
            keyboardType: TextInputType.multiline,
            validator: const FieldValidator(fieldName: 'Message').validator,
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
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
    return WaterButton(
      onPressed: () {},
      text: 'button.click_to_call'.tr(),
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
    );
  }
}
