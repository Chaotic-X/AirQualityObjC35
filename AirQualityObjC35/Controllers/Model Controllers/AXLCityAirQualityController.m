//
//  AXLCityAirQualityController.m
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

#import "AXLCityAirQualityController.h"
#import "AXLCityAirQuality.h"

static NSString * const baseURLString = @"https://api.airvisual.com/";
static NSString * const version = @"v2";
static NSString * const countryComponent = @"countries";
static NSString * const stateComponent = @"states";
static NSString * const cityComponent = @"cities";
static NSString * const cityDetailsComponent = @"city";
static NSString * const apiKey = @"1a399127-79cc-4cc2-8f10-62ad71d7bb2c";

@implementation AXLCityAirQualityController

+(instancetype)sharedInstance
{
    static AXLCityAirQualityController * sharedInstace = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        sharedInstace = [AXLCityAirQualityController new];
    });
    return sharedInstace;
}

-(void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:baseURLString];
    NSURL * apiversionURL = [baseURL URLByAppendingPathComponent:version];
    NSURL * countryURL = [apiversionURL URLByAppendingPathComponent:countryComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an errro in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDict = topLevelDict[@"data"];
            NSMutableArray *countries = [NSMutableArray new];
            for (NSDictionary *countryDict in dataDict)
            {
                NSString *country = [[NSString alloc] initWithString:countryDict[@"country"]];
                [countries addObject:country];
            }
            completion(countries);
        }
    }]resume];
    
} //End of Fetch Supported Countries

-(void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:baseURLString];
    NSURL * apiversionURL = [baseURL URLByAppendingPathComponent:version];
    NSURL * statesURL = [apiversionURL URLByAppendingPathComponent:stateComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:statesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an errro in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDict = topLevelDict[@"data"];
            NSMutableArray *states = [NSMutableArray new];
            for (NSDictionary *stateDict in dataDict)
            {
                NSString *state = stateDict[@"state"];
                [states addObject:state];
            }
            completion(states);
        }
    }]resume];
   
} //End of Fetch Supported States

-(void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:baseURLString];
    NSURL * apiversionURL = [baseURL URLByAppendingPathComponent:version];
    NSURL * citiesURL = [apiversionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:citiesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an errro in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDict = topLevelDict[@"data"];
            NSMutableArray *cities = [NSMutableArray new];
            for (NSDictionary *cityDict in dataDict)
            {
                NSString *city = cityDict[@"city"];
                [cities addObject:city];
            }
            completion(cities);
        }
    }]resume];
} //End of Fetch Supported Cities

-(void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(AXLCityAirQuality * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:baseURLString];
    NSURL * apiversionURL = [baseURL URLByAppendingPathComponent:version];
    NSURL * cityURL = [apiversionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:cityQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an errro in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDict = topLevelDict[@"data"];
            AXLCityAirQuality *cityAQI = [[AXLCityAirQuality alloc] initWithDictionary:dataDict];
            completion(cityAQI);
        }
    }]resume];
} //End of City Details
@end
