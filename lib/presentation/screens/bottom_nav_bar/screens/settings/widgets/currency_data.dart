import 'dart:developer';

import 'package:irhebo/domain/providers/currency.dart';

import '../../../../../../app/global_imports.dart';

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
    return Consumer<CurrencyProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: provider.currencyModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              var data = provider.currencyModel?.data?[index];
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
            },
          );
        }
      },
    );
  }
}
