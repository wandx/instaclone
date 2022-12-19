import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/app/widgets/camera_capture/bloc/camera_capture_bloc.dart';

class CameraCaptureScreen extends StatelessWidget {
  const CameraCaptureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CameraCaptureBloc()..add(InitCamera()),
      child: const CameraCaptureView(),
    );
  }
}

class CameraCaptureView extends StatelessWidget {
  const CameraCaptureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<CameraCaptureBloc, CameraCaptureState>(
            listener: (context, state) {
              if (state is CameraCaptureConfirmed) {
                Navigator.pop(context, state.image);
              }
            },
            builder: (context, state) {
              if (state is CameraCaptureLoading) {
                return const Center(
                  child: Text('Loading...'),
                );
              }

              if (state is CameraCaptureSuccess) {
                return Center(
                  child: Image.file(state.image),
                );
              }

              return Builder(builder: (context) {
                if (context.read<CameraCaptureBloc>().cameraController ==
                    null) {
                  return const Center(
                    child: Text('Reading camera...'),
                  );
                }
                return CameraPreview(
                  context.read<CameraCaptureBloc>().cameraController!,
                );
              });
            },
          ),
          BlocBuilder<CameraCaptureBloc, CameraCaptureState>(
            builder: (context, state) {
              if (state is CameraCaptureSuccess) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<CameraCaptureBloc>().add(ClearImage());
                        },
                        child: Text('Clear'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CameraCaptureBloc>().add(ConfirmImage());
                        },
                        child: Text('Confirm'),
                      ),
                    ],
                  ),
                );
              }
              return Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CameraCaptureBloc>().add(CaptureImage());
                  },
                  child: Text('Take Image'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
