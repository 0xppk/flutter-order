import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:order/common/components/custom_form_field.dart";
import "package:order/common/const/colors.dart";
import "package:order/common/layout/root_layout.dart";
import "package:order/user/model/user_model.dart";
import "package:order/user/provider/user_me_provider.dart";

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);

    return RootLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(height: 16),
                const _SubTitle(),
                Image.asset(
                  "asset/img/misc/logo.png",
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: "이메일을 입력해주세요",
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요",
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: state is UserModelLoading
                      ? null
                      : () async {
                          await ref.read(userMeProvider.notifier).login(
                                username: username,
                                password: password,
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: const Text(
                    "로그인",
                  ),
                ),
                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    "회원가입",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "환영합니다!",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "이메일과 비밀번호를 입력해서 로그인해주세요!\n오늘도 성공적인 주문이 되길 :)",
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
