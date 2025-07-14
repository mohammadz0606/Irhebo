import 'dart:developer';

import 'package:irhebo/domain/providers/currency.dart';

import '../../../../../../app/global_imports.dart';
import '../../../../../widgets/app_button.dart';

class CurrencyData extends StatefulWidget {
  const CurrencyData({super.key});

  @override
  State<CurrencyData> createState() => _CurrencyDataState();
}

class _CurrencyDataState extends State<CurrencyData> {
  @override
  void initState() {
    Provider.of<CurrencyProvider>(context, listen: false).getCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Consumer<CurrencyProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: provider.currencyModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              var data = provider.currencyModel?.data?[index];
              return AppButton(
                backGroundColor: Get.find<AppController>().darkMode
                    ? AppDarkColors.darkContainer2
                    : AppLightColors.primaryColor,
                title: Get.locale?.languageCode == 'ar'
                    ? data?.symbolAr ?? ''
                    : data?.symbolEn ?? '',
                borderColor: (AppPreferences(sl())
                                .getString(key: AppPrefsKeys.CURRENCY) ??
                            'usd') ==
                        data?.code
                    ? AppDarkColors.greenContainer
                    : null,
                onPressed: (AppPreferences(sl())
                                .getString(key: AppPrefsKeys.CURRENCY) ??
                            'usd') ==
                        data?.code
                    ? null
                    : () async {
                        await provider.onChangeCurrency(
                          data?.code ?? 'usd',
                        );
                      },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 4.97 * (w / 100));
            },
          );
        }
      },
    );
  }
}
/*
return RadioListTile(
                value: data?.code ?? '',
                groupValue: AppPreferences(sl()).getString(key: AppPrefsKeys.CURRENCY) ?? 'USD',
                dense: true,
                title: Text(
                  Get.locale?.languageCode == 'ar'
                      ? data?.symbolAr ?? ''
                      : data?.symbolEn ?? '',
                  style: Get.theme.textTheme.bodyMedium,
                ),
                onChanged: (value) async {
                  await provider.onChangeCurrency(value!);
                },
              );
 */
