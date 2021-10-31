import Foundation

// MARK: - Weather
class Weather: Codable {
    var city: City?
    var cod: String?
    var message: Double?
    var cnt: Int?
    var list: [WeatherDetail]?

//    init(city: City?, cod: String?, message: Double?, cnt: Int?, list: [WeatherDetail]?) {
//        self.city = city
//        self.cod = cod
//        self.message = message
//        self.cnt = cnt
//        self.list = list
//    }
}

// MARK: - List
class WeatherDetail: Codable {
    var dt, sunrise, sunset: Int?
    var temp: Temp?
    var feelsLike: FeelsLike?
    var pressure, humidity: Int?
    var weather: [WeatherElement]?
    var speed: Double?
    var deg: Int?
    var gust: Double?
    var clouds: Int?
    var pop, rain: Double?

//    init(dt: Int?, sunrise: Int?, sunset: Int?, temp: Temp?, feelsLike: FeelsLike?, pressure: Int?, humidity: Int?, weather: [WeatherElement]?, speed: Double?, deg: Int?, gust: Double?, clouds: Int?, pop: Double?, rain: Double?) {
//        self.dt = dt
//        self.sunrise = sunrise
//        self.sunset = sunset
//        self.temp = temp
//        self.feelsLike = feelsLike
//        self.pressure = pressure
//        self.humidity = humidity
//        self.weather = weather
//        self.speed = speed
//        self.deg = deg
//        self.gust = gust
//        self.clouds = clouds
//        self.pop = pop
//        self.rain = rain
//    }
}

// MARK: - FeelsLike
class FeelsLike: Codable {
    var day, night, eve, morn: Double?

//    init(day: Double?, night: Double?, eve: Double?, morn: Double?) {
//        self.day = day
//        self.night = night
//        self.eve = eve
//        self.morn = morn
//    }
}


// MARK: - WeatherElement
class WeatherElement: Codable {
    var id: Int?
    var main, description, icon: String?

//    init(id: Int?, main: String?, weatherDescription: String?, icon: String?) {
//        self.id = id
//        self.main = main
//        self.description = weatherDescription
//        self.icon = icon
//    }
}
