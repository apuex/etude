#!/usr/bin/perl -w
use SOAP::Lite;
#my $url = 'http://127.0.0.1:8080/services/FSUService?wsdl';
my $url = 'http://localhost:8080/FSUService/services/FSUService?wsdl';
my $service = SOAP::Lite->service($url);
print "invoke(hello): ", $service->invoke("hello");
print "\n";
