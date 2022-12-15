git clone https://github.com/Arnvidr/gentoo-overlay.git /var/db/repos/arnvidr-overlay

/etc/portage/repos.conf/arnvidr.conf:
=====================================
[arnvidr-overlay]
priority = 50
location = /var/db/repos/arnvidr-overlay
sync-type = git
sync-uri = https://github.com/Arnvidr/gentoo-overlay.git
auto-sync = Yes
