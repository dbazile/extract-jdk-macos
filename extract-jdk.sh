#!/bin/bash -e

INTERMEDIARY='./__extractjdk-work__'
MOUNTPOINT='./__extractjdk-mountpoint__'
CMD=$(basename $0)
cleanup() {
	echo "$CMD: Cleaning up..."
	rm -rf "$INTERMEDIARY"
	hdiutil detach "$MOUNTPOINT" 1>/dev/null
	exit 1
}
trap 'cleanup' ERR

echo  ##########################################################################

dmgfile=$(ls -1t ./jdk-*.dmg 2>/dev/null | head -1)
if [ ! -e "$dmgfile" ]; then
	echo "$CMD: error: could not find a jdk .dmg file in current directory"
	exit 1
fi

echo "$CMD: Mounting '$dmgfile'..."
hdiutil attach "$dmgfile" -mountpoint "$MOUNTPOINT" 1>/dev/null

echo  ##########################################################################

pkgfile=$(ls -1 $MOUNTPOINT/*.pkg)
if [ "$(echo "$pkgfile"|wc -l)" -gt 1 ]; then
	echo "$CMD: error: $dmgfile contains more than one .pkg file"
	exit 1
fi

echo "$CMD: Extracting '$pkgfile' into '$INTERMEDIARY'..."
pkgutil --expand "$pkgfile" "$INTERMEDIARY"

echo  ##########################################################################

pattern_payloadfile="$INTERMEDIARY/jdk*.pkg/Payload"
payloadfile=$(ls -1 $pattern_payloadfile)
if [ "$(echo $payloadfile|wc -l)" -gt 1 ]; then
	echo "$CMD: error: $pattern_payloadfile matched more than one file"
	exit 1
fi

foldername=${dmgfile%.dmg}
rm -rf $foldername
mkdir $foldername
echo "$CMD: Extracting '$payloadfile' into '$foldername'..."
tar -xv --strip-components 3 -C "$foldername" -f $payloadfile 'Contents/Home' 2>&1|sed 's/^/    | /'

echo  ##########################################################################

echo "$CMD: JDK successfully extracted to '$foldername'"
$foldername/bin/java  -version 2>&1|sed 's/^/    | /'
$foldername/bin/javac -version 2>&1|sed 's/^/    | /'

echo  ##########################################################################

cleanup
