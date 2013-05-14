use strict;
use Test::More tests => 2;

use Algorithm::RankAggregate::AverageRating;

# http://en.wikipedia.org/wiki/Borda_count
# each array of array are (Memphis, Nashville, Chattanooga, Knoxville)
my @case_00 = (
    [1, 2, 3, 4],
    [4, 1, 2, 3],
    [4, 3, 1, 2],
    [4, 3, 2, 1],
);
my @ans_00 = (3.25, 2.25, 2, 2.5);

my @case_01 = (
    [1, 2, 3, 4],
    [4, 1, 2, 3],
    [4, 3, 1, 2],
    [4, 3, 2, 1],
);
my @voters_01 = (42,26,15,17);
my @ans_01 = (68.5, 51.5, 56.75, 73.25);

my $bc0 = Algorithm::RankAggregate::AverageRating->new();
my $result_00 = $bc0->aggregate_rank_to_rating(\@case_00);
is_deeply($result_00, \@ans_00);

my $bc1 = Algorithm::RankAggregate::AverageRating->new(\@voters_01);
my $result_01 = $bc1->aggregate_rank_to_rating(\@case_01);
is_deeply($result_01, \@ans_01);
