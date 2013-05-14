use strict;
use Test::More tests => 3;

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
my $result_00 = $ar0->aggregate(\@case_00);
is_deeply($result_00, \@ans_00);

my $ar1 = Algorithm::RankAggregate::AverageRank->new(\@voters_01);
my $result_01 = $ar1->aggregate(\@case_01);
is_deeply($result_01, \@ans_01);


my @case_02 = (
    [-26.8,  -3.8, -11.2, -9.4, -2.7],
    [-24.8,  18.2, -8.0,  -3.4, 18.0],
    [-17.7,  13.0, -2.4,  -5.7, 12.9],
);

my $ar2 = Algorithm::RankAggregate::AverageRank->new();
# give point to attribute which is ranked higher than 4
my $result_02 = $ar2->aggregate(\@case_02);
my @ans_02 = (5, 1, 4, 3, 2);
is_deeply($result_02, \@ans_02);
