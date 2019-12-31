#!/usr/bin/perl -w
use SOAP::Lite;
my $url = 'http://127.0.0.1:9876/ts?wsdl';
my $service = SOAP::Lite->service($url);
print "Current time is: ", $service->getTimeAsString();
print "\nElapsed milliseconds from the epoch: ", $service->getTimeAsElapsed();
print "\n"
