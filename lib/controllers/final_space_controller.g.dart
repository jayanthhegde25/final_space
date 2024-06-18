// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_space_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FinalSpaceController on FinalSpaceControllerBase, Store {
  late final _$userDataAtom =
      Atom(name: 'FinalSpaceControllerBase.userData', context: context);

  @override
  List<dynamic> get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(List<dynamic> value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  late final _$selectedIndexAtom =
      Atom(name: 'FinalSpaceControllerBase.selectedIndex', context: context);

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$getCharactersAsyncAction =
      AsyncAction('FinalSpaceControllerBase.getCharacters', context: context);

  @override
  Future<List<CharactersModel>> getCharacters() {
    return _$getCharactersAsyncAction.run(() => super.getCharacters());
  }

  late final _$getEpisodeAsyncAction =
      AsyncAction('FinalSpaceControllerBase.getEpisode', context: context);

  @override
  Future<List<EpisodeModel>> getEpisode() {
    return _$getEpisodeAsyncAction.run(() => super.getEpisode());
  }

  @override
  String toString() {
    return '''
userData: ${userData},
selectedIndex: ${selectedIndex}
    ''';
  }
}
