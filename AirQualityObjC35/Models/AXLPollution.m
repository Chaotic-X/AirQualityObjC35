//
//  AXLPollution.m
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

#import "AXLPollution.h"

@implementation AXLPollution

-(instancetype)initWithInt:(NSInteger)aqi
{
    self = [super init];
    if (self){
        _airQualityIndex = aqi;
    }
    return self;
}

@end

@implementation AXLPollution (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"] intValue];
    return [self initWithInt:aqi];
}

@end
