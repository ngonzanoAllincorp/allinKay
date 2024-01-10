import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../src/utils/my_colors.dart';
import 'validar_controller.dart';

class ValidarPage extends StatefulWidget {
  const ValidarPage({super.key});

  @override
  State<ValidarPage> createState() => _ValidarPageState();
}

class _ValidarPageState extends State<ValidarPage>
    with TickerProviderStateMixin {
  final ValidarController _con = ValidarController();
  // late StreamSubscription subscription;
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  void dispose() {
    // subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.cPri1,
      body: SingleChildScrollView(
          child: Center(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Image.asset(
                'assets/logo/launcher_icon.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              // SizedBox(
              //   width: 40,
              //   height: 40,
              //   child: CircularProgressIndicator(
              //     color: MyColors.cPri1,
              //     backgroundColor: MyColors.cPri4,
              //   ),
              // ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: Column(
                    children: [
                      Text('una app de',
                          style: TextStyle(
                            fontSize: 12,
                            color: MyColors.cPri5,
                            // fontFamily: 'Poppins',
                          )),
                      Text(
                        'FUTURA',
                        style: TextStyle(
                          fontSize: 15,
                          color: MyColors.cPri5,
                          letterSpacing: 2,
                          fontFamily: 'antaris_cf',
                        ),
                      ),
                      Text('ANALITICA AVANZADA',
                          style: TextStyle(
                            fontSize: 11,
                            color: MyColors.cPri5,
                            fontFamily: 'adlinnaka',
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
