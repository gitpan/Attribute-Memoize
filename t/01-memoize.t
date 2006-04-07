#
# $Id: 01-memoize.t,v 0.1 2006/04/07 15:34:57 dankogai Exp dankogai $
#
use strict;
use warnings;
use Test::More tests => 25;
use Attribute::Memoize;

sub mfib : Memoize {
    return $_[0] < 2 ? $_[0] :  mfib($_[0]-1) + mfib($_[0]-2);
}
sub fib {
    return $_[0] < 2 ? $_[0] :  fib($_[0]-1) + fib($_[0]-2);
}

for (0..22){
    is(fib($_), mfib($_), "fib($_) == " . mfib($_));
}

our %cache = ();
sub cfib : Memoize(SCALAR_CACHE=>[HASH=>\%cache]) {
    return $_[0] < 2 ? $_[0] :  cfib($_[0]-1) + cfib($_[0]-2);
}

is(cfib(42), mfib(42), "cfib(42) == mfib(42)");
is(scalar keys %cache, 43, ":Memoize(Options) works ok");
__END__
