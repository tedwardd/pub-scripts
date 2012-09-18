#!/usr/bin/env bash
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
PARSE=$1

if [ x$PARSE = x ]
then
    echo "You have not defined a file to parse."
    exit
else
    echo "Processing..."
fi

SRC=../audiophile/
WEBROOT=..
DEST=.
EPNUM=$(cat $PARSE | grep EPNUM | cut -f2 -d"=" )
DESC=$(cat $PARSE | grep DESC | cut -f2 -d"=" )
LINKS=$(cat $PARSE | grep LINKS | cut -f2 -d"=")
SUM_ogg=$(sha256sum $SRC/gnuWorldOrder_$EPNUM.ogg | cut -f1 -d" " )
SUM_spx=$(sha256sum $SRC/gnuWorldOrder_$EPNUM.spx | cut -f1 -d" " )

if [ x$SUM_ogg = x ]
then
    echo "Are you sure you have new episodes to post? I can't find one in $SRC"
    exit
else
    echo "Processing..."
fi

# if we are here, we have passed all dummy-checks
# so grab the most up-to-date versions of our site
cp $WEBROOT/index.html .
cp $WEBROOT/???.xml .

# and start modding them
for CODEC in {ogg,spx}
do 
BYTES=$(du -b $SRC/gnuWorldOrder_$EPNUM.$CODEC | cut -f1 )
SUM=$(sha256sum $SRC/gnuWorldOrder_$EPNUM.$CODEC | cut -f1 -d" " )
echo "<!--SCRIPTENT--><item><title>gnuWorldOrder_$EPNUM</title><link>http://www.gnuworldorder.info/audiophile/gnuWorldOrder_$EPNUM.$CODEC</link><author>klaatu@hackkerpubliccradio.org (notKlaatu)</author><enclosure length=\"$BYTES\" url=\"http://www.gnuworldorder.info/audiophile/gnuWorldOrder_$EPNUM.$CODEC\" type=\"audio/$CODEC\"/><pubDate>$(date)</pubDate><description>${DESC} sha256sum=$SUM</description></item>" > /tmp/$CODEC.feed

## sed it into the file
sed -i "s%<!--SCRIPTENT-->%$(cat /tmp/$CODEC.feed)%" $DEST/$CODEC.xml
echo "$CODEC feed done"
done

## that was xml feed
## now for html

echo "<!--SCRIPTENT--><div class=\"item\"><div class=\"label\">$(date)<span class=\"labelEp\"> \&#47; Listen:<a href=\"./audiophile/gnuWorldOrder_$EPNUM.ogg\">Ogg $EPNUM</a> \&#47; <a href=\"./audiophile/gnuWorldOrder_$EPNUM.spx\">Speex $EPNUM</a></span></div><div class=\"copy\"><p>${DESC}</p><dl><dt>sha256sums:</dt><dd>ogg $SUM_ogg</dd><dd>speex $SUM_spx</dd></dl><dl><dt>Links:</dt>${LINKS}</dl></div></div>" > /tmp/gwo.html

## sed it into the file
sed -i "s%<!--SCRIPTENT-->%$(cat /tmp/gwo.html)%" $DEST/index.html
echo "webpage done"

## now re-distribute the files back into source directory
cp -f ./???.xml ./index.html $WEBROOT

## legacy support
cp -f ./???.xml ./index.html $WEBROOT/thebadapples/HOME/

## cleanup
rm -f parse*
echo "# this is a parse file for gnu world order oggcast" > parse.template
echo " " >> parse.template
echo "# url for a link should be <dd><a href="foo">bar</a></dd>" >> parse.template
echo " " >> parse.template
echo "# description needs no escaping" >> parse.template
echo " " >> parse.template
echo "EPNUM=" >> parse.template
echo " " >> parse.template
echo "DESC=" >> parse.template
echo " " >> parse.template
echo "LINKS=" >> parse.template
echo "Check the site and feeds to make sure nothing got screwed up."

## dont delete index.html and *xml just in case