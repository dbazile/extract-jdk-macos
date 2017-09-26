# extract-jdk-macos

> Bash script for extracting JDK from macOS .dmg, thus avoiding whatever shenanigans
>  Oracle decides to inflict upon users of its installers.


## Purpose

This little bash script fills the gap left by Oracle not providing a simple
`.tar.gz` of the JDK for macOS.


## Usage

1. Download the [macOS JDK `.dmg` file](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) as normal (you may also need [JCE 8](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html) ([info](https://stackoverflow.com/questions/30278104/encryptionoperationnotpossibleexception-by-jasypt-with-bouncy-castle))).
2. Download this script script to the same folder as the `.dmg` file
3. From the terminal, execute:

```
./extract-jdk.sh
```

### Output

```
extract-jdk.sh: Mounting './jdk-8u111-macosx-x64.dmg'...

extract-jdk.sh: Extracting './__extractjdk-mountpoint__/JDK 8 Update 111.pkg' into './__extractjdk-work__'...

extract-jdk.sh: Extracting './__extractjdk-work__/jdk180111.pkg/Payload' into './jdk-8u111-macosx-x64'...
    | x bin
    | x bin/appletviewer
    | x bin/extcheck
    | x bin/idlj
    | x bin/jar
    | x bin/jarsigner
    | x bin/java
    | x bin/javac
    ...
    | x man/man1/wsgen.1
    | x man/man1/wsimport.1
    | x man/man1/xjc.1
    | x README.html
    | x release
    | x src.zip
    | x THIRDPARTYLICENSEREADME-JAVAFX.txt
    | x THIRDPARTYLICENSEREADME.txt

extract-jdk.sh: JDK successfully extracted to './jdk-8u111-macosx-x64'
    | java version "1.8.0_111"
    | Java(TM) SE Runtime Environment (build 1.8.0_111-b14)
    | Java HotSpot(TM) 64-Bit Server VM (build 25.111-b14, mixed mode)
    | javac 1.8.0_111

extract-jdk.sh: Cleaning up...
```

## Disclaimer

As with all shell scripts posted by strangers on Github, use at your own risk.

## Credits

Thanks to [this article](http://augustl.com/blog/2014/extracting_java_to_folder_no_installer_osx/) for explaining the extraction process.
