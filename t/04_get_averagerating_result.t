use strict;
use Test::More tests => 1;

use Algorithm::RankAggregate::AverageRating;

my @case_00 = (
    [1, 2, 3, 4, 5],
    [5, 4, 2, 1, 3],
    [5, 1, 4, 3, 2],
);

my @ans_00 = (3.66666666666667, 2.33333333333333, 3, 2.66666666666667, 3.33333333333333);

my $ar = Algorithm::RankAggregate::AverageRating->new();

my $result_00 = $ar->get_averagerating_result(\@case_00);
is_deeply($result_00, \@ans_00);
