#
# $Id: Memoize.pm,v 0.1 2006/04/07 15:34:57 dankogai Exp dankogai $
#
package Attribute::Memoize;
use 5.008001;
use strict;
use warnings;
our $VERSION = sprintf "%d.%02d", q$Revision: 0.1 $ =~ /(\d+)/g;
use Attribute::Handlers;
use Memoize;
sub UNIVERSAL::Memoize :ATTR(CODE) {
    my ($package, $symbol, $referent, $attr, $data, $phase) = @_;
    my $funcname = $package . '::' .  *{$symbol}{NAME};
    memoize $funcname, @$data;
}

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Attribute::Memoize - Memoize your sub via attribute

=head1 SYNOPSIS

  use Attribute::Memoize;
  sub fib : Memoize {
    return $_[0] < 2 ? $_[0] :  fib($_[0]-1) + fib($_[0]-2);
  }

=head1 DESCRIPTION

Attribute::Memoize memoizes your sub via attribute.  The code above is
exactly identical to:

  use Memoize;
  memoize('fib')
  sub fib : Memoize {
    return $_[0] < 2 ? $_[0] :  fib($_[0]-1) + fib($_[0]-2);
  }

But more DWIMery.

=head2 CAVEAT

You can also pass memoize options as follows;

  use Attribute::Memoize;
  sub fib : Memoize(LIST_CACHE => MERGE) {
    return $_[0] < 2 ? $_[0] :  fib($_[0]-1) + fib($_[0]-2);
  }

But you have to be careful if you want to do something like:

  my %cache;
  sub fib : Memoize(SCALAR_CACHE => [HASH => \%cache]) {
    return $_[0] < 2 ? $_[0] :  fib($_[0]-1) + fib($_[0]-2);
  }
  print fib(42), "\n";
  use Data::Dumper;
  print Dumper \%cache;

You'd be surprised to find that %cache is empty.  This is because the
attribute handling is done in CHECK phase so C<%cache> points to
nowhere.  You can overcome this as follows;

  our %cache; # so it is visible
  sub fib : Memoize(SCALAR_CACHE => [HASH => \%cache]) {
    return $_[0] < 2 ? $_[0] :  fib($_[0]-1) + fib($_[0]-2);
  }
  print fib(42), "\n";
  use Data::Dumper;
  print Dumper \%cache;

Well, if you want this kind of minute control, IMHO simply using
Memoize should do better.

=head2 EXPORT

None by default.

=head1 SEE ALSO

L<Attribute::Handler>, L<Memoize>

=head1 AUTHOR

Dan Kogai, E<lt>dankogai@dan.co.jpE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Dan Kogai

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
