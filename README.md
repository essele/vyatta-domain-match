vyatta-domain-match
===================

Vyatta configuration templates and scripts to support matching domains from dns lookups
and populating address groups (ipsets) with the IP addresses of the results.

This allows support for routing/qos/firewalling based on specific domains.

Depends on dnsmasq package >= 2.64 (needs to be upgraded in standard distribution)

This required dns forwarding to be configured so that dnsmasq is running.

Configuration commands:

    service
        dns
            domain-match <name>
                domain <domain name>
                group <address group>

## domain

    match against this domain name. multiple can be defined for each set.
    see dnsmasq --ipset syntax for more information

## group

    populate this address group with the results

Example:

    service
        dns
            domain-match iplayer
                domain bbc.co.uk
                domain bbci.co.uk
                domain akamaihd.com
                group via-uk
 
## Technical details

This package just creates an additional config in /etc/dnsmasq.d
which takes advantage of the ipset capability within dnsmasq.

On reboot it is removed before config load and re-created if
related configuration exists.
