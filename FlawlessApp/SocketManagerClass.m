//
//  SocketManagerClass.m
//  FlawlessApp
//
//  Created by Ирина on 23.07.18.
//  Copyright © 2018 trivajlo. All rights reserved.
//

#import "SocketManagerClass.h"

@implementation SocketManagerClass

- (void) initializeSocket
{
    NSURL *socketUrl = [NSURL URLWithString:@""];
    self.socetClient = [[SocketIOClient alloc] initWithSocketURL:socketUrl config:@{@"log" : @YES,
                                                                                    @"connectParams" : @{@"clientType" : @"IOS", @"clientVersion" : @"9.3.3",
                                                                                                         @"token" : @"eb7786d54e390fa82caecb86a9da0fa7"}}];
    
    
    [self.socetClient on:@"currentAmount" callback:^(NSArray* data, SocketAckEmitter* ack) {
        
        NSLog(@"Socket connect succesfully");
        double cur = [[data objectAtIndex:0] floatValue];
        
        [[self.socetClient emitWithAck:@"canUpdate" with:@[@(cur)]] timingOutAfter:0 callback:^(NSArray* data) {
            
            // send message from client to server:
            [self.socetClient emit:@"update" with:@[@{@"amount": @(cur + 2.50)}]];
        }];
        
        [ack with:@[@"Got your currentAmount, ", @"dude"]];
    }];
    
    [self.socetClient connect];
}

+ (SocketManagerClass*) sharedInstance
{
    static SocketManagerClass *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[[self class] alloc] init];
    }
    return sharedInstance;
}

@end
