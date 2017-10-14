#!/bin/sh

javac src/main/java/org/tw/pi/framebuffer/TestFrameBuffer.java src/main/java/org/tw/pi/framebuffer/FrameBuffer.java


jniResult=libFrameBufferJNI.so

jniJdkHeader=$JAVA_HOME/include
jniSysHeader=$JAVA_HOME/include/linux

rm "$jniResult" 2>/dev/null

echo "javah"
javah -d src/main/c -classpath src/main/java org.tw.pi.framebuffer.FrameBuffer
rm src/main/c/org_tw_pi_framebuffer_FrameBuffer_ScreenPanel.h
rm src/main/c/org_tw_pi_framebuffer_FrameBuffer_UpdateThread.h


echo "gcc"
gcc -Wall -O2 -fPIC -o "$jniResult" -shared -I "$jniJdkHeader"  -I "$jniSysHeader" -I src/main/c src/main/c/FrameBuffer.c

echo
ls -l "$jniResult"
echo "done"

