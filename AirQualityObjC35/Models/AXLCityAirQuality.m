//
//  AXLCityAirQuality.m
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

#import "AXLCityAirQuality.h"
#import "AXLWeather.h"
#import "AXLPollution.h"

@implementation AXLCityAirQuality


- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(AXLWeather *)weather pollution:(AXLPollution *)pollution
{
    self = [super init];
    if (self){
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}
@end

@implementation AXLCityAirQuality (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString * city = dictionary[@"city"];
    NSString * state = dictionary[@"state"];
    NSString * country = dictionary[@"country"];
    NSDictionary * currentInfo = dictionary[@"current"];
    
    AXLWeather *weather = [[AXLWeather alloc] initWithDictionary:currentInfo[@"weather"]];
    AXLPollution *pollution = [[AXLPollution alloc] initWithDictionary:currentInfo[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
