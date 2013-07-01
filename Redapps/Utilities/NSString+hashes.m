//
//  NSString+hashes.m
//
//  Created by Ryan Copley on 5/5/13.
//  Copyright (c) 2013 Ryan Copley. All rights reserved.
//

#import "NSString+hashes.h"
#import <CommonCrypto/CommonDigest.h>

//iOS & Mac OS X Compatibility hack
#define uint32 UInt32

@implementation NSString (hashes)
+ (NSString*)stringWithRepeatCharacter:(char)character times:(unsigned int)repetitions;
{
    char repeatString[repetitions + 1];
    memset(repeatString, character, repetitions);
    
    // Set terminating null
    repeatString[repetitions] = 0;
    
    return [NSString stringWithUTF8String: repeatString];
}

-(NSString*) sha256{
    
    NSString* clear = self;
    
    NSMutableString *asciiCharacters = [NSMutableString string];
    for (NSInteger i = 32; i < 127; i++)  {
        [asciiCharacters appendFormat:@"%c", (int)i];
    }
    
    NSCharacterSet *nonAsciiCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:asciiCharacters] invertedSet];
    
    clear = [[clear componentsSeparatedByCharactersInSet:nonAsciiCharacterSet] componentsJoinedByString:@""];
    
    const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, (uint32)keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

-(NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}



@end


