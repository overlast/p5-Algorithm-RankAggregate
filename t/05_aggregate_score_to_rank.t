use strict;
use Test::More tests => 2;

use Algorithm::RankAggregate::AverageRank;

# http://en.wikipedia.org/wiki/Borda_count
# each array of array are (Memphis, Nashville, Chattanooga, Knoxville)

my @case_00 = (
    [4, 3, 2, 1],
    [1, 4, 3, 2],
    [1, 2, 4, 3],
    [1, 2, 3, 4],
);
my @ans_00 = (4, 2, 1, 3);

my @case_01 = (
    [4, 3, 2, 1],
    [1, 4, 3, 2],
    [1, 2, 4, 3],
    [1, 2, 3, 4],
);
my @voters_01 = (42,26,15,17);
my @ans_01 = (3, 1, 2, 4);

my $ar0 = Algorithm::RankAggregate::AverageRank->new();
my $result_00 = $ar0->aggregate_score_to_rank(\@case_00);
is_deeply($result_00, \@ans_00);

my $ar1 = Algorithm::RankAggregate::AverageRank->new(\@voters_01);
my $result_01 = $ar1->aggregate_score_to_rank(\@case_01);
is_deeply($result_01, \@ans_01);
