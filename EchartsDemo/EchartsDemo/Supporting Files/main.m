//
//  main.m
//  EchartsDemo
//
//  Created by mason on 2017/7/10.
//
//

#import "AppDelegate.h"


int main(int argc, char *argv[])
{
	@autoreleasepool
	{
		// Create the UIApplication object and initialize the main event loop.
		int retVal = UIApplicationMain(argc, 
			argv, 
			nil, 
			NSStringFromClass([AppDelegate class]));
		
		// NOTE: UIApplicationMain never returns because the application is either sent to the background or is killed. It cannot exit "normally".
		return retVal;
	}
}