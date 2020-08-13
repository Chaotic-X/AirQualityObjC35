//
//  AXLWeather.m
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

#import "AXLWeather.h"

@implementation AXLWeather

- (instancetype)initWithWeatherInfo:(NSInteger)temperature humidity:(NSInteger)humidity windSpeed:(float)windSpeed
{
    self = [super init];
    if (self){
        _temperature = temperature;
        _humidity = humidity;
        _windSpeed = windSpeed;
    }
    return self;
}

@end

@implementation AXLWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger temperature = [dictionary[@"tp"] intValue];
    NSInteger humidity = [dictionary[@"hu"] intValue];
    float windSpeed = [dictionary[@"ws"] floatValue];
    
    return [self initWithWeatherInfo:temperature humidity:humidity windSpeed:windSpeed];
}

@end
