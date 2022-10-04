class ModelDateWeather {
  Location? location;
  Current? current;
  Forecast? forecast;

  ModelDateWeather.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    current  =  Current.fromJson(json['current']);
    forecast = Forecast.fromJson(json['forecast']);
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  String? tzId;
  String? localtime;
  dynamic lat;
  dynamic lon;
  dynamic localtimeEpoch;

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    tzId = json['tz_id'];
    localtimeEpoch = json['localtime_epoch'];
    localtime = json['localtime'];
  }
}

class Current {
  dynamic last_updated_epoch;
  String? last_updated;
  dynamic? temp_c;
  dynamic? temp_f;
  dynamic? is_day;
  Condition? condition;
  int? humidity;
  dynamic? cloud;
  dynamic feelslike_c;
  dynamic wind_kph;

  Current.fromJson(Map<String, dynamic> json) {
    last_updated_epoch = json['last_updated_epoch'];
    last_updated = json['last_updated'];
    temp_c = json['temp_c'];
    temp_f = json['temp_f'];
    is_day = json['is_day'];
    condition = Condition.fromJson(json['condition']);
    cloud = json['cloud'];
    feelslike_c = json['feelslike_c'];
    humidity = json['humidity'];
    wind_kph = json['wind_kph'];
  }
}

class Condition {
  String? text;

  String? icon;

  dynamic code;

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }
}

class Forecast{
  List<ForeCastDays>? foreCastDays = [] ;
  Forecast.fromJson(Map<String, dynamic> json) {
      json['forecastday'].forEach((element){
        foreCastDays!.add(ForeCastDays.fromJson(element));
    }) ;
  }
}

class ForeCastDays{
  String? date ;
  dynamic? date_epoch ;
  Day? day ;
  Astro? astro ;
  List<Hour>? hour = [] ;

  ForeCastDays.fromJson(Map<String, dynamic> json) {
    date = json['date'] ;
    date_epoch = json['date_epoch'] ;
    day = Day.fromJson(json['day']) ;
    astro = Astro.fromJson(json['astro']) ;
    json['hour'].forEach((element){
      hour!.add(Hour.fromJson(element));
    });
  }

}

class Day{
  dynamic maxtemp_c ;
  dynamic mintemp_c ;
  dynamic avgtemp_c ;
  ConditionDay? condition ;
  dynamic uv ;
  dynamic maxwind_kph ;
  dynamic avghumidity ;

  Day.fromJson(Map<String, dynamic> json) {
    maxtemp_c = json['maxtemp_c'] ;
    mintemp_c = json['mintemp_c'] ;
    avgtemp_c = json['avgtemp_c'] ;
    maxwind_kph = json['maxwind_kph'] ;
    avghumidity = json['avghumidity'] ;
    uv = json['uv'] ;
    condition = ConditionDay.fromJson(json['condition']) ;
  }

}
class ConditionDay{
  String? text ;
  String? icon ;
  dynamic code ;

  ConditionDay.fromJson(Map<String, dynamic> json) {
    text = json['text'] ;
    icon = json['icon'] ;
    code = json['code'] ;
  }
}
class Astro{
  String? sunrise ;
  String? sunset ;
  String? moonrise ;
  String? moonset ;
  String? moon_phase ;
  String? moon_illumination ;

  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'] ;
    sunset = json['sunset'] ;
    moonrise = json['moonrise'] ;
    moonset = json['moonset'] ;
    moon_phase = json['moon_phase'] ;
    moon_illumination = json['moon_illumination'] ;
  }

}

class Hour{
  dynamic time_epoch ;
  String? time ;
  dynamic temp_c ;
  dynamic is_day ;
  ConditionHour? conditionHour ;

  Hour.fromJson(Map<String, dynamic> json) {
    time_epoch = json['time_epoch'] ;
    time = json['time'] ;
    temp_c = json['temp_c'] ;
    is_day = json['is_day'] ;
    conditionHour = ConditionHour.fromJson(json['condition']) ;
  }

}

class ConditionHour {

  String? text ;
  String? icon ;
  dynamic code ;

  ConditionHour.fromJson(Map<String, dynamic> json) {
    text = json['text'] ;
    icon = json['icon'] ;
    code = json['code'] ;
  }
}