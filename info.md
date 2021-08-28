# INFO

## Swift version (5.4.2)

```sh
$ xcrun swift -version

```

## Install Cocoapods

```sh
$ sudo gem install cocoapods
```

#### Create Podfile

```sh
$ pod init
```

#### Install Podfile

```sh
$ pod install
```

## How to use

Open project as workspace.
Go to Pods/Podfile, and click library from Target Membership.

## Useless Warnings from XPC service

1 - From Xcode menu open: Product > Scheme > Edit Scheme.
2 - On your Environment Variables set OS_ACTIVITY_MODE = disable.