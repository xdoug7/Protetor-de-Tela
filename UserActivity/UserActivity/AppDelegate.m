//
//  AppDelegate.m
//  UserActivity
//
//  Created by Douglas Ferreira on 30/07/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "AppDelegate.h"
#include <stdlib.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self resetarTimerDeInatividade];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self resetarTimerDeInatividade];
}

- (void)resetarTimerDeInatividade {
    if (self.interacaoTimer) {
        [self.interacaoTimer invalidate];
        self.interacaoTimer = nil;
    }
    
    NSInteger tempoMaximoSemInteracao = 10; // em segundos
    
    self.interacaoTimer = [NSTimer scheduledTimerWithTimeInterval:tempoMaximoSemInteracao
                                                           target:self
                                                         selector:@selector(tempoInativoExcedido)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)tempoInativoExcedido{
    // Verificamos se a view controller que esta na tela já não é o protetor
    UINavigationController *visibleViewController = (UINavigationController*) self.window.rootViewController;

    NSLog(@"%@", visibleViewController.topViewController.class);
    if (![visibleViewController.topViewController isKindOfClass:[ProtetorTelaViewController class]]) {
        // Se estiver usando storyboard é só pegar a referência e apresentar na tela.
        ProtetorTelaViewController *protetorDeTelaVC = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"ProtetorTelaViewController"];
        [self.window.rootViewController presentViewController:protetorDeTelaVC animated:YES completion:nil];
    }
}

@end
