#!/bin/sh


{

printf "\nStarted test\n";

printf "\nPrint info:\n\n"
pactl info

printf "\nList sinks:\n\n"
pactl list sinks | grep Name

printf "\nQuery default sink:\n\n"
pactl info | sed -ne 's/^.*Default Sink: //p'

printf "\nPlay sine tone\n\n"
speaker-test -t sine -f 200 -b 1024 -p 100 -l 1

printf "\nFinished test";

sleep 1

} > test.log 2>&1