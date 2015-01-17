package Sub::Iterator;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       gen_array_iterator
                       gen_fh_iterator
               );

sub gen_array_iterator {
    my $array = shift;
    my $i = 0;
    return sub {
        if ($i >= @$array) { undef } else { $array->[$i++] }
    };
}

sub gen_fh_iterator {
    my $fh = shift;
    return sub {
        if (eof($fh)) { undef } else { ~~<$fh> }
    };
}

1;
# ABSTRACT: Generate iterator coderefs

=head1 SYNOPSIS

 use Sub::Iterator qw(gen_array_iterator gen_fh_iterator);

 my $sub = gen_array_iterator([1, 2, 3]);
 $sub->(); # -> 1
 $sub->(); # -> 2
 $sub->(); # -> 3
 $sub->(); # -> undef


=head1 FUNCTIONS

=head2 gen_array_iterator(\@ary) -> code

=head2 gen_fh_iterator($fh) -> code

=cut
