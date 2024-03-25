import 'package:flutter/material.dart';

import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';

import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/util/global.dart';

import 'package:gestao_viajem_onfly/feature/boarding_pass/model/boarding_pass_model.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/view/screen/boarding_pass_screen.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/view/widget/card_boarding_pass_widget.dart';

class TravelsScreen extends StatefulWidget {
  const TravelsScreen({super.key});

  @override
  State<TravelsScreen> createState() => _TravelsScreenState();
}

class _TravelsScreenState extends State<TravelsScreen> {
  late BoardingPassModel boardingPass;
  late BoardingPassModel boardingPass2;
  @override
  void initState() {
    final mock = {
      "passenger": "Gabriel Hirano",
      "number": "BP456789",
      "airlineCompany": "Gol Linhas Aéreas",
      "departure": 1674950400000,
      "arrival": 1674957600000,
      "origin": {
        "name":
            "Aeroporto Internacional de Guarulhos - Governador André Franco Montoro",
        "acronym": "GRU",
        "location": "São Paulo"
      },
      "destination": {
        "name": "Aeroporto Internacional de Congonhas",
        "acronym": "CGH",
        "location": "São Paulo"
      },
      "seat": "12C",
      "gate": "A3",
      "terminal": "Terminal 2"
    };

    final mock2 = {
      "passenger": "Gabriel Hirano",
      "number": "GV295164",
      "airlineCompany": "Azul",
      "departure": 1721014400000,
      "arrival": 1721022600000,
      "origin": {
        "name": "Aeroporto Internacional de Congonhas",
        "acronym": "CGH",
        "location": "São Paulo"
      },
      "destination": {
        "name":
            "Aeroporto Internacional de Guarulhos - Governador André Franco Montoro",
        "acronym": "GRU",
        "location": "São Paulo"
      },
      "seat": "12C",
      "gate": "A3",
      "terminal": "Terminal 2"
    };
    boardingPass = BoardingPassModel.fromMap(mock);
    boardingPass2 = BoardingPassModel.fromMap(mock2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.whiteGrey,
      appBar: AppBar(
        backgroundColor: appColors.colorBrandPrimaryBlue,
        title: AppText(
          text: 'Minhas viagens',
          textStyle: AppTextStyle.headerH4,
          textColor: appColors.white,
        ),
        iconTheme: IconThemeData(color: appColors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            InkWell(
                onTap: () {
                  appNavigator.navigate(
                    BoardingPassScreen(boardingPass: boardingPass),
                  );
                },
                child: CardBoardingPassWidget(
                  boardingPass: boardingPass,
                  withShadow: true,
                )),
            InkWell(
              onTap: () {
                appNavigator.navigate(
                  BoardingPassScreen(boardingPass: boardingPass2),
                );
              },
              child: CardBoardingPassWidget(
                  boardingPass: boardingPass2, withShadow: true),
            ),
          ],
        ),
      ),
    );
  }
}
