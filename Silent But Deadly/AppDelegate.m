//
//  AppDelegate.m
//  Silent But Deadly
//
//  Created by Mark McCorkle on 2/11/13.
//  Copyright (c) 2013 dcgod. All rights reserved.
//

#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self playAlarmSound];
    _window.isVisible = NO;
    //
}

-(void) playAlarmSound
{
    NSString *path = [NSString stringWithFormat:@"%@%@",
                      [[NSBundle mainBundle] resourcePath],
                      @"/silence.aiff"];
    
    NSURL *filepath = [NSURL fileURLWithPath:path isDirectory:NO];
    NSSound *sound = [[NSSound alloc] initWithContentsOfURL:filepath byReference:YES];
    [sound setLoops:YES];
    [sound play];
}

@end
