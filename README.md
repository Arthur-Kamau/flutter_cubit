# flutter_cubit

A new Flutter project.

## Getting Started

This project is a flutter application that illustrate the use of bloc with cubit to maintain state.
The project  performs a get request to `http://ip-api.com/json` and updates the ui.

Also equtable is used to aid in comparison of types without overridiing `==`

since `http://ip-api.com/json` does not allow https we had to add `android:usesCleartextTraffic="true"`  in the app manifest.