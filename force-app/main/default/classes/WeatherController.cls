public with sharing class WeatherController {
    
    private static String BASE_URL = '';
    private static String API_KEY = '';
    
   
    @AuraEnabled(cacheable=true)
    public static weatherWrapper getWeatherDetails(String city) {

        String endpoint = BASE_URL+'?q='+city+'&units=metrics'+'&APPID='+API_KEY;
        // System.debug(endpoint);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndPoint(endpoint);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        System.debug(res);

        weatherWrapper obj = new weatherWrapper();
        if(res.getStatusCode()==200){
            Map<String,Object> mpp = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            Map<String,Object> weather = (Map<String,Object>) mpp.get('main');
            List<Object> message = (List<Object>) mpp.get('weather');
            Map<String,Object> st = (Map<String,Object>) message[0];
            // System.debug(st.get('main'));
            obj.city = String.valueOf(mpp.get('name'));
            obj.temp = String.valueOf(weather.get('temp'));
            obj.feelsLike = String.valueOf(weather.get('feels_like'));
            obj.tempMin = String.valueOf(weather.get('temp_min'));
            obj.tempMax = String.valueOf(weather.get('temp_max'));
            obj.pressure = String.valueOf(weather.get('pressure'));
            obj.humidity = String.valueOf(weather.get('humidity'));
            obj.status = String.valueOf(st.get('main'));
        }
        
        return obj;

    }

    public class weatherWrapper{
        @AuraEnabled public String city{get;set;}
        @AuraEnabled public String temp {get;set;}
        @AuraEnabled public String feelsLike {get;set;}
        @AuraEnabled public String tempMin {get;set;}
        @AuraEnabled public String tempMax {get;set;}
        @AuraEnabled public String pressure {get;set;}
        @AuraEnabled public String humidity {get;set;}
        @AuraEnabled public String status {get;set;}
    }
}
