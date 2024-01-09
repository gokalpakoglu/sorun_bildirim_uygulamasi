import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/bloc/home_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/blocs/bloc_status.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/custom_elevated_button.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/custom_text_form_field.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.gr.dart';

@RoutePage()
class AddProblemView extends StatefulWidget {
  const AddProblemView({super.key});

  @override
  State<AddProblemView> createState() => _AddProblemViewState();
}

class _AddProblemViewState extends State<AddProblemView> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return BlocListener<HomeBloc, HomeState>(
              listenWhen: (previous, current) =>
                  previous.appStatus != current.appStatus,
              listener: (context, state) {
                var formStatus = state.appStatus;
                if (formStatus is SubmissionSuccess) {
                  context.router.pushAndPopUntil(const MainRoute(),
                      predicate: (_) => false);
                } else if (formStatus is SubmissionFailed) {
                  _showErrorDialog(
                      context.loc.errorTitle, state.message, context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomElevatedButton(
                      text: context.loc.takePhoto,
                      onPressed: () async {
                        final XFile? pickedImage = await _picker.pickImage(
                          source: ImageSource.camera,
                        );
                        if (pickedImage != null) {
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<HomeBloc>(context).add(
                            AddImages([pickedImage]),
                          );
                        }
                      },
                    ),
                    CustomElevatedButton(
                      text: context.loc.selectPhotos,
                      onPressed: () async {
                        final List<XFile> pickedImages =
                            await _picker.pickMultiImage();
                        if (pickedImages.isNotEmpty) {
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<HomeBloc>(context).add(
                            AddImages(pickedImages),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      onChanged: (value) {
                        BlocProvider.of<HomeBloc>(context).add(
                          HomeTitleChanged(title: value),
                        );
                      },
                      hintText: context.loc.title,
                      obscureText: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      onChanged: (value) {
                        BlocProvider.of<HomeBloc>(context).add(
                          HomeDescriptionChanged(description: value),
                        );
                      },
                      obscureText: false,
                      enabled: true,
                      hintText: context.loc.description,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16.0),
                    CustomElevatedButton(
                      onPressed: () {
                        context.router.push(const AddProblemLocationRoute());
                      },
                      text: context.loc.selectOnMap,
                    ),
                    const SizedBox(height: 16.0),
                    CustomElevatedButton(
                      onPressed: (state.isValidTitle &&
                              state.isValidDescription &&
                              state.lat != null &&
                              state.lng != null &&
                              state.images != [])
                          ? () {
                              try {
                                BlocProvider.of<HomeBloc>(context)
                                    .add(AddReportSubmitted());
                              } catch (_) {}
                            }
                          : null,
                      text: (state.appStatus is SubmissionLoading)
                          ? "......"
                          : context.loc.submit,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showErrorDialog(String title, String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(context.loc.ok),
          ),
        ],
      );
    },
  );
}
