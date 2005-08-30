use 5.006;
use inc::Module::Install;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

my $version = '0.03';
my $name    = 'Log::Delta';
my $fname   = "Log-Delta-$version";

my $prereqs = {
    'Test::More'        => 0,
#    'Class::Singleton'  => 0,
};

sub MY::postamble { "

changes:
	echo 'Changelog for Perl extension $name' > $$
	echo '' >> $$
	-darcs changes >> $$ && mv $$ Changes
	rm -f $$
                                
deb: changes
	(head -1 debian/changelog | grep $version) || exit 1
	rm -f $fname.tar.gz *.deb *.changes
	-chmod 755 debian/rules
	\$(MAKE) dist
	tar zxvf $fname.tar.gz
	cd $fname && dpkg-buildpackage -b -rfakeroot -tc

tgz:
	rm -f Log-Delta.tgz
	ln -s $fname.tar.gz Log-Delta.tgz

";
}

WriteMakefile(
    NAME              => $name,
    VERSION           => $version,
    PREREQ_PM         => $prereqs,
    ABSTRACT          => 'Logging object timing information',
    AUTHOR            => 'Mark Lawrence <nomad@null.net>',
);
