import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/screens/home/faq/widgets/faq_list_item.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _buildFAQItems(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'screen.faq'.tr(),
        fontSize: 24.0,
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

  Widget _buildFAQItems() {
    return SeparatedColumn(
      children: [
        FAQListItem(
          header: 'Will I be charged immediately once '
              'I have acquired a parking space from another person?',
          body: 'Response 1',
        ),
        FAQListItem(
          header: 'Where exactly can I use this app?',
          body: 'Response 2',
        ),
        FAQListItem(
          header: 'How do I leave feedback on the app?',
          body: 'Response 3',
        ),
        FAQListItem(
          header: 'Which parking spaces are traded on the App?',
          body: 'Response 4',
        ),
        FAQListItem(
          header: 'Is a payment immediately taken out once '
              'I press ‘Reserve’ I would like to take?',
          body: 'Response 5',
        ),
        FAQListItem(
          header: 'Which parking spaces are traded on the App?',
          body: 'Response 6',
        ),
        FAQListItem(
          header: 'Is a payment immediately taken out once '
              'I press ‘Reserve’ I would like to take?',
          body: 'Response 7',
        ),
        FAQListItem(
          header: 'Terms & Conditions',
          body: 'Response 8',
        ),
      ],
      includeOuterSeparators: true,
    );
  }
}
