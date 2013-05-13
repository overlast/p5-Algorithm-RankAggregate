use strict;
use Test::More tests => 1;

use Algorithm::RankAggregate::BordaCount;

# http://en.wikipedia.org/wiki/Borda_count
# each array of array are (Memphis, Nashville, Chattanooga, Knoxville)
my @case_00 = (
    [4, 3, 2, 1],
    [1, 4, 3, 2],
    [1, 2, 4, 3],
    [1, 2, 3, 4],
);
my @voters_00 = (42,26,15,17);
my @ans_00 = (126, 194, 173, 107);

my $bc = Algorithm::RankAggregate::BordaCount->new(\@voters_00);

my $result_00 = $bc->aggregate_score_to_count(\@case_00, 3);
is_deeply($result_00, \@ans_00);
