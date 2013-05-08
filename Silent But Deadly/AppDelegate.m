//
//  AppDelegate.m
//  Silent But Deadly
//
//  Created by Mark McCorkle on 2/11/13.
//  Copyright (c) 2013 dcgod. All rights reserved.
//

#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>

#define kShouldHideTrayIconUserDefaults @"SilentButDeadly_ShouldHideTrayIcon"

@interface AppDelegate ()
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (unsafe_unretained) IBOutlet NSMenu *trayMenu;
@end

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _window.isVisible = NO;
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kShouldHideTrayIconUserDefaults]) {
        [self showTrayIcon];
    }
    
    [self playAlarmSound];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    [self showTrayIcon];
    
    return YES;
}

- (void)showTrayIcon
{
    if (self.statusItem) return;
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    self.statusItem.highlightMode = YES;
    self.statusItem.image = [NSImage imageNamed:@"trayIconTemplate.png"];
    self.statusItem.toolTip = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    self.statusItem.menu = self.trayMenu;
    
    [self.statusItem setEnabled:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kShouldHideTrayIconUserDefaults];
}

- (IBAction)hideTrayIcon:(NSMenuItem *)sender
{
    NSInteger result = [[NSAlert alertWithMessageText:@"Are you sure you want to hide the icon from the status bar?"
                                        defaultButton:@"Hide icon"
                                      alternateButton:@"Cancel"
                                          otherButton:nil
                            informativeTextWithFormat:@"You can restore it at any time by launching Silent But Deadly again from the Finder."] runModal];
    
    if (!result) return;
    
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
    self.statusItem = nil;
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kShouldHideTrayIconUserDefaults];
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
