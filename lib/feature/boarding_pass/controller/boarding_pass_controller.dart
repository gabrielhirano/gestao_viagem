import 'package:gestao_viajem_onfly/core/util/base_state.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/model/boarding_pass_model.dart';

class BoardingPassController {
  final state = BaseState<List<BoardingPassModel>>();

  Future<void> getBoardingPasses() async {
    await state.execute(() => getBoardingPassesMock());
  }

  Future<List<BoardingPassModel>> getBoardingPassesMock() async {
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

    return [BoardingPassModel.fromMap(mock), BoardingPassModel.fromMap(mock2)];
  }
}
