import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/splash/splash_cubit.dart';
import 'package:water/ui/splash/widgets/splash_loading_icon.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLoadingIcon(),
            const SizedBox(height: 16.0),
            _buildLoadingText(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SplashCubit>().simulateFakeProgress();
        },
      ),
    );
  }

  Widget _buildLoadingIcon() {
    return const SplashLoadingIcon(
      color: const Color.fromARGB(255, 210, 244, 255),
      fillColor: const Color.fromARGB(255, 0, 92, 185),
    );
  }

  Widget _buildLoadingText() {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (_, state) {
        if (state.progress > 0.0)
          return const Text(
            'Loading...',
            style: TextStyle(
              color: Color.fromARGB(255, 47, 55, 65),
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          );
        else
          return SizedBox.shrink();
      },
    );
  }
}
