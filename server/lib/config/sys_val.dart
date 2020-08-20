import '../model/bloc.dart';

class SysVal {

static final MINER_TIME_ADJ_SHORT = 4; // Minimum 1 Minute
static final MINER_TIME_ADJ_LONG = 6; // Maximum 3 Minutes

static final GENESIS_BLOC = Bloc(
    hash: '1337',
    lastHash: '1337',
    difficulty: 3,
    timestamp: DateTime(2000, 1, 1, 13, 37, 0, 0, 0),
    data: '');

}