import ballerina.net.http;
import connectors as conn;
import weather.util as abc;
import ballerina.log;
    
service<http> travel {    
    @http:resourceConfig {
        methods:["GET"]
        
    }
    
    resource weather (http:Request req, http:Response res ) {
        
        var start="";
        var end="";
        var wa="";
        var waypoints=0;

        try{
            map params = req.getQueryParams();
        
            start, _ = (string)params.start;
            end, _ = (string)params.end;
            wa, _ = (string)params.waypoints;
        
            waypoints,_ = <int> wa;
            if(waypoints<=0){
                error err = {msg:"waypoints should be a valid int"};
                throw err;
            }

            json retval = getWeatherSummery(start,end,waypoints);
            
            res.setJsonPayload(retval);
            _ = res.send();
            log:printInfo("Completed request for trip from : "+ start + " to " + end);
        
        }

        catch(error err){
            println("error occured while processing user request: " + err.msg);
            log:printErrorCause("error log with cause", err);
            
            res.setJsonPayload({error:err.msg});
            _ = res.send();
        }     
    }
}


function getWeatherSummery(string start, string end, int waypoints) ( json ) {
    endpoint<conn:openwatherConnector> openWeatherEP {
            create conn:openwatherConnector();
    }


    json startCoord = openWeatherEP.getCoordinatesFromCity(start);
    json endCoord = openWeatherEP.getCoordinatesFromCity(end);


    var startLo = startCoord.lon.toString();
    var startLa =startCoord.lat.toString();

    var endLo =endCoord.lon.toString();
    var endLa  =endCoord.lat.toString();


    var startLon ,_ = <float>startLo;
    var startLat ,_ = <float>startLa;
    var endLon ,_ = <float>endLo;
    var endLat ,_ = <float>endLa;

    float lonDiff = (endLon - startLon)/waypoints;
    float latDiff = (endLat - startLat)/waypoints;



    int i=0;
    json finalResult ={};

    while(i<waypoints+1){
        
        float tmpLon = startLon + lonDiff*i;
        float tmpLat = startLat + latDiff*i;
        i = i+1;

        json result = openWeatherEP.getWeatherFromCoordinates(<string>tmpLon,<string>tmpLat);
        finalResult[result.Name.toString()]=result;
    }

    return finalResult;



}

