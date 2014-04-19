cfgdir = $(datadir)/vyatta-cfg/templates
opdir = $(datadir)/vyatta-op/templates
curverdir = $(sysconfdir)/config-migrate/current
bin_sudo_usersdir = $(bindir)/sudo-users

vprefix = /opt/vyatta
vsbindir = $(vprefix)/sbin

sbin_SCRIPTS = scripts/vyatta-domain-match.pl

#bin_sudo_users_SCRIPTS = scripts/vyatta-restart-crond.sh

checkparamsonrebootdir = $(bindir)/sudo-users/check-params-on-reboot.d
checkparamsonreboot_SCRIPTS =
checkparamsonreboot_SCRIPTS += scripts/check-params-on-reboot.d/reset-domain-match

curver_DATA = cfg-version/dnsmasq@1

cpiop = find  . ! -regex '\(.*~\|.*\.bak\|.*\.swp\|.*\#.*\#\)' -print0 | \
  cpio -0pd

install-exec-hook:
	mkdir -p $(DESTDIR)$(cfgdir)
	cd templates-cfg; $(cpiop) $(DESTDIR)$(cfgdir)
	mkdir -p $(DESTDIR)$(opdir)
	cd templates-op; $(cpiop) $(DESTDIR)$(opdir)
