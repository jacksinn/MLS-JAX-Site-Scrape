#!/usr/bin/perl

use LWP::Simple;

$numPages=$ARGV[0];

open OUTPUT,">/home/steven/out.html";
for($i=1;$i<=$numPages*10;$i+=10){
	print $i."\n";
        $content=get("http://neflorida.cbdevonshire.com/property/proplist.asp?VAR_SearchType=openhouse&pagestart=".$i);
        print OUTPUT $content;
        print OUTPUT "******************\n******************\n******************\n";
}
close OUTPUT;

open INPUT,"/home/steven/out.html";
open FEED,">/home/steven/feed.txt";

$tmp="";
while($line = <INPUT>){
        chomp($line);
	$line =~ s/\x0D//g; #strips ^M characters

        $feedInfo=$line;

        if($line =~ m/(\<b\>)(\d{6})(\<\/b\>)/){
		#print $tmp."\n";
		if($2 ne $tmp){
			print FEED "\n\n".$2."\n";
		}$tmp=$2;
        }
        #chomp($line);
        if($feedInfo =~ m/(\&nbsp\;)([^\&]+)(\&nbsp\;)(\([^\<]+)/i){
			print FEED "$2 | $4\n";
	}
}

close INPUT;
close FEED;
