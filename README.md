# air-adapter-example
Examples for OpenFin Air adapter

## Run the example

Go to lib directory and run air-example.exe, which will install Air runtime if needed.

## Build the example

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

## Getting help

Please contact support@openfin.co

    