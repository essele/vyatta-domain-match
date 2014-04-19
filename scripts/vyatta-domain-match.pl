#!/usr/bin/perl
# Module: vyatta-domain-match.pl
#
# Maintainer: Lee Essen <lee.essen@nowonline.co.uk>
#
# Copyright (C) 2014 Lee Essen
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

use strict;
use warnings;

use lib "/opt/vyatta/share/perl5/";
use Vyatta::Config;

my $vcDMS = new Vyatta::Config();
my $cf = "/etc/dnsmasq.d/domain-match";
my $config = undef;

#
# If we create a config for dnsmasq then we will need to restart it
#
sub dnsmasq_restart {
	my $dnsmasq_init = '/etc/init.d/dnsmasq';
	system("$dnsmasq_init restart >&/dev/null");
}

#
# We'll delete the config file first, then recreate if we need to
#
unlink($cf);

$vcDMS->setLevel('service dns domain-match');

#
# Go through pulling out the relevant bits of config...
#
my @dms = $vcDMS->listNodes(".");
foreach my $dm (@dms) {
	my $group = $vcDMS->returnValue("$dm group");
	my @domains = $vcDMS->returnValues("$dm domain");
	
	foreach my $domain (@domains) {
		$config .= "ipset=/$domain/$group\n";
	}
} 

#
# If we have a valid config then we need to write it out, and then
# make sure that dnsmasq is restarted if it's already running.
#
if($config) {
	my $cfh;
	
	open($cfh, '>', $cf) or die "$0: unable to create domain-match dnsmasq config\n";
	print $cfh $config;
	close $cfh;
	
	if(-e '/var/run/dnsmasq/dnsmasq.pid') {
		dnsmasq_restart();
	}
} 
	
