//
//  CacheMethod.m
//  PensionTreasure
//
//  Created by xiaowei on 16/8/2.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "CacheMethod.h"

#define Defaults [NSUserDefaults standardUserDefaults]

@implementation CacheMethod



+(void)cacheArray:(NSArray *)object forKey:(NSString *)key{
    
    NSString *filePath = [CacheMethod filePathWithName:key];
    [object writeToFile:filePath atomically:YES];
    
}

+(void)cacheNSDictory:(NSDictionary *)object forKey:(NSString *)key{

    NSString *filePath = [CacheMethod filePathWithName:key];
    
    [object writeToFile:filePath atomically:YES];

}


+(NSArray *)getTheCacheArrayWithKey:(NSString*)key{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [[self class] filePathWithName:key];
        if ([fileManager fileExistsAtPath:filePath]) {
            
            return [[NSArray alloc] initWithContentsOfFile:filePath];;
        }
    
    return nil;
    
}
+(NSDictionary *)getTheCacheDictoryWithKey:(NSString*)key{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self class] filePathWithName:key];
    if ([fileManager fileExistsAtPath:filePath]) {
        
        return [[NSDictionary alloc] initWithContentsOfFile:filePath];;
    }
    
    return nil;
}

+(void)cleanCacheWithKey:(NSString*)key{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self class] filePathWithName:key];

    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

+(void)userDefaultSetValue:(NSString *)str forKey:(NSString *)key{
    
    [Defaults setObject:str forKey:key];
    [Defaults synchronize];
}

+ (id )userDefaultvalueForKey:(NSString *)key{
    return [Defaults valueForKey:key];
}


+ (NSString *)filePathWithName:(NSString *)name
{
    NSString *documentsDirectory = [CacheMethod createBaseDirectoryAtPath];
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
}


+ (NSString*)createBaseDirectoryAtPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    documentsDirectory = [documentsDirectory stringByAppendingString:@"/ERHCACHE"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:documentsDirectory isDirectory:nil]) {
        __autoreleasing NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES
                                                   attributes:nil error:&error];
    }
    
    return documentsDirectory;
}



@end
