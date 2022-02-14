import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/promo_codes/promo_codes_bloc.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/utils/debounce.dart';

class PromoCodeInput extends StatelessWidget {
  PromoCodeInput({Key? key}) : super(key: key);

  final Debounce _applyPromoCode = Debounce(const Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: WaterText(
                'text.have_promo_code'.tr(),
                fontSize: 18.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(width: 12.0),
            SizedBox(
              width: 160.0,
              child: WaterFormInput(
                hintText: 'input.enter_promo_code'.tr(),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (code) {
                  context.promoCodes.add(
                    const ResetPromoCode(),
                  );

                  if (code.trim().isEmpty) {
                    return;
                  }

                  _applyPromoCode(() {
                    context.promoCodes.add(
                      ApplyPromoCode(code: code),
                    );
                  });
                },
              ),
            ),
          ],
        ),
        BlocBuilder<PromoCodesBloc, PromoCodesState>(
          builder: (_, state) {
            if (state is PromoCodesInitial) {
              return const SizedBox.shrink();
            }

            String status = '';
            if (state is PromoCodeLoaded) {
              status = 'text.promo_code_applied'.tr();
            } else if (state is PromoCodeExpired) {
              status = 'text.promo_code_expired'.tr();
            } else if (state is PromoCodeNotExists) {
              status = 'text.promo_code_not_exist'.tr();
            } else if (state is PromoCodeIsOver) {
              status = 'text.promo_code_is_over'.tr();
            }

            return WaterText(
              status,
              fontSize: 18.0,
              lineHeight: 1.5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryText,
            ).withPadding(0.0, 18.0, 0.0, 0.0);
          },
        ),
      ],
    ).withPaddingAll(24.0);
  }
}
