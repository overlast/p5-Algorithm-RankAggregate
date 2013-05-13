use strict;
use Test::More tests => 1;

use Algorithm::RankAggregate::BordaRank;

# http://en.wikipedia.org/wiki/Borda_count
# each array of array are (Memphis, Nashville, Chattanooga, Knoxville)
my @case_00 = (
    [4, 3, 2, 1],
    [1, 4, 3, 2],
    [1, 2, 4, 3],
    [1, 2, 3, 4],
);
my @voters_00 = (42,26,15,17);
my @ans_00 = (3, 1, 2, 4);  # (126, 194, 173, 107);

my $br = Algorithm::RankAggregate::BordaRank->new(\@voters_00);
my $result_00 = $br->aggregate(\@case_00, 3);
is_deeply($result_00, \@ans_00);
