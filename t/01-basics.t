#!perl

use 5.010;
use strict;
use warnings;

use File::Temp qw(tempfile);
use Test::More 0.98;

use Sub::Iterator qw(
                        gen_array_iterator
                        gen_fh_iterator
                );

subtest gen_array_iterator => sub {
    my $ary = [1,2,3];
    my $sub = gen_array_iterator($ary);
    is(ref($sub), "CODE");
    is($sub->(), 1);
    is($sub->(), 2);
    is($sub->(), 3);
    ok(!defined($sub->()));

    # the same array can be reiterated
    $sub = gen_array_iterator($ary);
    is(ref($sub), "CODE");
    is($sub->(), 1);
};

subtest gen_fh_iterator => sub {
    my ($fh, $filename) = tempfile();
    print $fh "1\n2\n3\n";
    close $fh;

    open $fh, "<", $filename;
    my $sub = gen_fh_iterator($fh);
    is(ref($sub), "CODE");
    is($sub->(), "1\n");
    is($sub->(), "2\n");
    is($sub->(), "3\n");
    ok(!defined($sub->()));
};

DONE_TESTING:
done_testing();
