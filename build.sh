set -e 
export PLAYDATE_SDK_PATH=/Users/nishantjha/Developer/PlaydateSDK
\rm -rf /Users/nishantjha/Desktop/pongdate/source/PongDate.pdx
/Users/nishantjha/Developer/PlaydateSDK/bin/pdc /Users/nishantjha/Desktop/pongdate/source/ /Users/nishantjha/Desktop/pongdate/PongDate.pdx &&
open /Users/nishantjha/Desktop/pongdate/PongDate.pdx
