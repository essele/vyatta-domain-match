cfgdir = $(datadir)/vyatta-cfg/templates
opdir = $(datadir)/vyatta-op/templates
bin_sudo_usersdir = $(bindir)/sudo-users

sbin_SCRIPTS = scripts/vyatta-domain-match.pl

checkparamsonrebootdir = $(bindir)/sudo-users/check-params-on-reboot.d
checkparamsonreboot_SCRIPTS =
checkparamsonreboot_SCRIPTS += scripts/check-params-on-reboot.d/reset-domain-match

cpiop = find  . ! -regex '\(.*~\|.*\.bak\|.*\.swp\|.*\#.*\#\)' -print0 | \
  cpio -0pd

install-exec-hook:
	mkdir -p $(DESTDIR)$(cfgdir)
	cd templates-cfg; $(cpiop) $(DESTDIR)$(cfgdir)
	mkdir -p $(DESTDIR)$(opdir)
	cd templates-op; $(cpiop) $(DESTDIR)$(opdir)
