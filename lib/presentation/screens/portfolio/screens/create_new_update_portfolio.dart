import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:irhebo/domain/providers/files_manager.dart';
import 'package:irhebo/presentation/screens/auth/register/widgets/upload_file.dart';

import '../../../../app/global_imports.dart';
import '../../../../domain/models/new_models/freelancer/freelancer_service_model.dart';
import '../../../../domain/params/new_params/freelanser/create_portfolio_param.dart';
import '../../../../domain/providers/freelancer/freelancer_portfolio.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/html_form.dart';
import '../../../widgets/normal_app_bar.dart';
import '../widgets/related_services.dart';
import '../widgets/upload_multiple_file.dart';

class CreateNewUpdatePortfolioScreen extends StatefulWidget {
  const CreateNewUpdatePortfolioScreen({super.key});

  @override
  State<CreateNewUpdatePortfolioScreen> createState() =>
      _CreateNewUpdatePortfolioScreenState();
}

class _CreateNewUpdatePortfolioScreenState
    extends State<CreateNewUpdatePortfolioScreen> {
  File? cove;
  final List<File> media = [];
  final List<int> services = [];
  late FilesManagerProvider filesManagerProvider;
  late FreelancerPortfolioProvider freelancerPortfolioProvider;
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  // List<int> selectedServices = [];
  String? urlCover;
  List<String>? mediaUrls;
  quill.QuillController quillController = quill.QuillController.basic();

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    quillController.dispose();
    super.dispose();
  }

  //dataForEdit = Get.arguments['data'];
  // _title.text = dataForEdit?.title ?? '';
  @override
  void initState() {
    filesManagerProvider =
        Provider.of<FilesManagerProvider>(context, listen: false);
    freelancerPortfolioProvider =
        Provider.of<FreelancerPortfolioProvider>(context, listen: false);
    //freelancerPortfolioProvider.desc.addListener(_onTextChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _onLoadEditData();
    });
    super.initState();
  }

  Future<void> _onLoadEditData() async {
    if (Get.arguments?['data'] != null) {
      await freelancerPortfolioProvider.getPortfolioDetails(
        Get.arguments?['id'],
        (data) async {
          media.clear();
          title.text = data?.title ?? '';
          desc.text = data?.description ?? '';
          //quillController = await quillControllerFromHtml(data?.description ?? '');
          urlCover = data?.media
              ?.firstWhere(
                (element) => element?.isCover == true,
              )
              ?.mediaPath;

          mediaUrls = (data?.media
                      ?.where((element) => element?.isCover == false)
                      .toList() ??
                  [])
              .map((e) => e?.mediaPath ?? '')
              .toList();

          services.addAll(data!.service!
              .map(
                (e) => e?.id ?? 0,
              )
              .toList());

          // selectedServices.addAll(
          //   data.service!
          //       .map(
          //         (e) => e?.id ?? 0,
          //       )
          //       .toList(),
          // );

          setState(() {});
        },
      );
    }
  }

  Future<quill.QuillController> quillControllerFromHtml(String html) async {
    final delta = HtmlToDelta().convert(html, transformTableAsEmbed: false);
    return quill.QuillController(
      document: quill.Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NormalAppBar(
        title: Get.arguments?['data'] != null
            ? "Update Portfolio"
            : "Crete Portfolio",
      ),
      body: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Consumer<FreelancerPortfolioProvider>(
          builder: (context, provider, child) {
            if (provider.isLoadingDetails && Get.arguments?['data'] != null) {
              return const Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        top: 4.97 * (w / 100),
                        left: 4.97 * (w / 100),
                        right: 4.97 * (w / 100),
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Create portfolio entries to showcase your work'
                                  .tr,
                              style: Get.textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Cover'.tr,
                            style: Get.textTheme.labelMedium,
                          ),
                          UploadFileWidget(
                            imageStartUrl: urlCover,
                            fileType: FileType.image,
                            onFileSelected: (file) {
                              log('DONE PIK FILE $file');
                              cove = file;
                              setState(() {});
                            },
                          ),
                          Text(
                            'Title'.tr,
                            style: Get.textTheme.labelMedium,
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            controller: title,
                            hint: "Enter request title",
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'Description'.tr,
                            style: Get.textTheme.labelMedium,
                          ),
                          const SizedBox(height: 20),

                          AppTextField(
                            controller: desc,
                            textInputType: TextInputType.multiline,
                            maxLines: 3,
                            textInputAction: TextInputAction.newline,
                            onChange: (value) {
                                    //quillController
                            },
                          ),
                          // AppTextField(
                          //   controller: desc,
                          //   textInputType: TextInputType.multiline,
                          //   readOnly: true,
                          //   onTap: () {
                          //     Get.bottomSheet(
                          //       HtmlFormat(
                          //         quillController: quillController,
                          //       ),
                          //       backgroundColor:
                          //           Get.find<AppController>().darkMode
                          //               ? AppDarkColors.darkScaffoldColor
                          //               : AppLightColors.pureWhite,
                          //       barrierColor: Get.find<AppController>().darkMode
                          //           ? AppDarkColors.darkContainer
                          //               .withOpacity(0.3)
                          //           : AppLightColors.shadow.withOpacity(0.3),
                          //       elevation: 0,
                          //     );
                          //   },
                          //   maxLines: 1,
                          //   textInputAction: TextInputAction.newline,
                          // ),
                          const SizedBox(height: 25),
                          RelatedServicesWidget(
                            initialValue: services,
                            onServicesSelected: (value) {
                              services.addAll(value);
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'Upload Image'.tr,
                            style: Get.textTheme.labelMedium,
                          ),
                          UploadMultipleFile(
                            urlsImage: mediaUrls,
                            onFilesSelected: (file) {
                              log('DONE PIK FILE ${file.length}');
                              media.addAll(file);
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  AppButton(
                    onPressed: () async {
                      if (Get.arguments?['data'] != null) {
                        if (title.text.trim().isEmpty ||
                            desc.text.trim().isEmpty||
                            services.isEmpty) {
                          AppSnackBar.openErrorSnackBar(
                            message: 'Please fill all fields'.tr,
                          );
                          return;
                        }
                        updateQuillWithHTML(desc.text, quillController);
                        await provider.updatePortfolio(
                          id: Get.arguments?['id'],
                          CreatePortfolioParam(
                            cover: cove,
                            description: quillController,
                            title: title.text,
                            services: services,
                            media: media.isEmpty ? null : media,
                          ),
                        );
                      } else {
                        if (media.isEmpty ||
                            cove == null ||
                            title.text.trim().isEmpty ||
                            quillController.document.isEmpty() ||
                            services.isEmpty) {
                          AppSnackBar.openErrorSnackBar(
                            message: 'Please fill all fields'.tr,
                          );
                          return;
                        }
                        updateQuillWithHTML(desc.text, quillController);
                        await provider.createPortfolio(
                          CreatePortfolioParam(
                            cover: cove!,
                            description: quillController,
                            title: title.text,
                            services: services,
                            media: media,
                          ),
                        );
                      }
                    },
                    title: Get.arguments?['data'] != null ? 'Update' : "Save",
                    isLoading: Get.arguments?['data'] != null
                        ? provider.isLoadingUpdate
                        : provider.isLoadingCreate,
                    backGroundColor: AppLightColors.greenContainer,
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }
          },
        ),
      ),
    );
  }


  void updateQuillWithHTML(String input, quill.QuillController quillController) {
    final html = _convertTextToHtml(input);
    final doc = quill.Document.fromDelta(
      Delta()..insert('$html\n'),
    );
    quillController.document = doc;
    setState(() {});
  }

  String _convertTextToHtml(String text) {
    final urlRegex = RegExp(r'(https?:\/\/[^\s]+)');
    final processed = text.replaceAllMapped(urlRegex, (match) {
      final url = match.group(0);
      return '<a href="$url">$url</a>';
    });
    return '<p>${processed.replaceAll('\n', '<br>')}</p>';
  }
}
