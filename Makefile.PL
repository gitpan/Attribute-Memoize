use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Attribute::Memoize',
    'VERSION_FROM'	=> 'Memoize.pm', # finds $VERSION
    'PREREQ_PM'		=> {
    	Memoize => 0,
    },
    dist                => {
        # don't ask about existing .tar.gz files
        COMPRESS => 'gzip --force --best'
    },
);
