import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/bloc/home_bloc.dart';
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final XFile? pickedImage = await _picker.pickImage(
                          source: ImageSource.camera,
                        );
                        if (pickedImage != null) {
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<HomeBloc>(context).add(
                            AddImages([
                              pickedImage
                            ]), // Tek bir resim listeye alınıyor.
                          );
                        }
                      },
                      child: const Text('Take Photo'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final List<XFile> pickedImages =
                            await _picker.pickMultiImage();
                        if (pickedImages.isNotEmpty) {
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<HomeBloc>(context).add(
                            AddImages(
                                pickedImages), // Birden fazla resim listeye alınıyor.
                          );
                        }
                      },
                      child: const Text('Select Photos'),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Title',
                        errorText: state.titleErrorMsg,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<HomeBloc>(context).add(
                          HomeTitleChanged(title: value),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Description',
                        errorText: state.descriptionErrorMsg,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<HomeBloc>(context).add(
                          HomeDescriptionChanged(description: value),
                        );
                      },
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        context.router.push(const AddProblemLocationRoute());
                      },
                      child: const Text('Select Location on Map'),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(AddReportSubmitted());
                        context.router.push(const MainRoute());
                      },
                      child: const Text('Submit'),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
