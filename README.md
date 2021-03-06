# OpenFin Air Adapter Example

## Overview 
Examples for OpenFin Air adapter

## Run
Go to lib directory and run air-example.exe, which will install Air runtime if needed.

## Build
The example requires lib/OpenFinAirAdapter-6.0.1.swc and lib/OpenFinAirNativeExtension-6.0.1.ane.

## Source Code Review
1. Create connection object:

        var cfg:RuntimeConfiguration = new RuntimeConfiguration("inter-app-messenger");

    This code just creates an instance of DesktopConnection and it does not try to connect to runtime.
2. Create an instance of RuntimeConfiguration and use it to launch Runtime:

        var cfg:RuntimeConfiguration = new RuntimeConfiguration("inter-app-messenger");
        cfg.appManifestUrl = "https://demoappdirectory.openf.in/desktop/config/apps/OpenFin/HelloOpenFin/app.json";
        cfg.onConnectionReady = onConnectionReady;
        cfg.onConnectionError = onConnectionError;
        cfg.onConnectionClose = onConnectionClose;
        cfg.connectionTimeout = 15000;  // milli-seconds
        runtimeLauncher = new RuntimeLauncher(cfg);

    onConnectionReady is called when Air adapter is successfully connected to Runtime


## API Documentation
The latest API doc is available [here](https://developer.openfin.co/docs/air/6.0.1/)

## Disclaimers
* This is a starter example and intended to demonstrate to app providers a sample of how to approach an implementation. 
* This is an open source project and all are encouraged to contribute.

## License
MIT

The code in this repository is covered by the included license.

However, if you run this code, it may call on the OpenFin RVM or OpenFin Runtime, which are covered by OpenFin’s Developer, Community, and Enterprise licenses. You can learn more about OpenFin licensing at the links listed below or just email us at support@openfin.co with questions.

https://openfin.co/developer-agreement/ <br/>
https://openfin.co/licensing/

## Support
Please enter an issue in the repo for any questions or problems. 
<br> Alternatively, please contact us at support@openfin.co    
