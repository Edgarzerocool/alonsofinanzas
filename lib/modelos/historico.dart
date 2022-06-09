
class historico {
  List<int> timestamp;
  String symbol;
  Null previousClose;
  double chartPreviousClose;
  Null end;
  Null start;
  List<double> close;
  int dataGranularity;

  historico(
      {this.timestamp,
        this.symbol,
        this.previousClose,
        this.chartPreviousClose,
        this.end,
        this.start,
        this.close,
        this.dataGranularity});

  historico.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'].cast<int>();
    symbol = json['symbol'];
    previousClose = json['previousClose'];
    chartPreviousClose = json['chartPreviousClose'];
    end = json['end'];
    start = json['start'];
    close = json['close'].cast<double>();
    dataGranularity = json['dataGranularity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['symbol'] = this.symbol;
    data['previousClose'] = this.previousClose;
    data['chartPreviousClose'] = this.chartPreviousClose;
    data['end'] = this.end;
    data['start'] = this.start;
    data['close'] = this.close;
    data['dataGranularity'] = this.dataGranularity;
    return data;
  }
}
