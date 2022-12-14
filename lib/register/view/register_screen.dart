import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/register/bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Form(
          key: context.read<RegisterBloc>().formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                TextFormField(
                  controller: context.read<RegisterBloc>().emailInput,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: context.read<RegisterBloc>().validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: context.read<RegisterBloc>().passwordInput,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: context.read<RegisterBloc>().validatePassword,
                ),
                const SizedBox(height: 20),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return const ElevatedButton(
                        onPressed: null,
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        context.read<RegisterBloc>().add(SubmitRegister());
                      },
                      child: const Text('Submit'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
