#!/bin/perl

# most of this code was pulled from SO

use strict;
use autodie;
use XML::LibXML;

my $path = $ARGV[0];
die "Usage: arcToKodi.pl <path>" 
    unless -d $path;

opendir( my $DIR, $path );
while ( my $entry = readdir $DIR ) {
    next unless -d $path . '/' . $entry;
    next if $entry eq '.' or $entry eq '..';
    my $currentDirectory = $path . "/" . $entry;
    opendir(my $anotherDir, $currentDirectory) or die "Cannot open directory: $!";
    my @files = readdir $anotherDir;
    foreach(@files) {
        my $fullFileName = $_;
        my ($ext) = $fullFileName =~ /((\.[^.\s]+)+)$/;
        (my $withoutExtension = $fullFileName) =~ s/\.[^.]+$//;
        if ($ext eq ".xml" && index($withoutExtension, 'meta') != -1) {
            my $currentXmlFile = "$currentDirectory/$fullFileName";
            my $currentNfoFile = "$currentDirectory/$withoutExtension.nfo";
            $currentNfoFile =~ s/_meta//;
            my $dom = XML::LibXML->load_xml(location => $currentXmlFile);
            open(OUTDATA, ">$currentNfoFile") or die "Couldn't open $currentNfoFile $!";
            my $title = $dom->findnodes('/metadata/title');
            my $plot = $dom->findnodes('/metadata/description');

            print "Creating $currentNfoFile\n";
            print OUTDATA "<movie>\n";
            print OUTDATA "    <title>$title</title>\n";
            print OUTDATA "    <plot>$plot</plot>\n";
            print OUTDATA "</movie>";

            close(OUTDATA);
        }
    }
}
closedir $DIR;
