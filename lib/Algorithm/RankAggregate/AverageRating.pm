package Algorithm::RankAggregate::AverageRating;

use strict;
use warnings;
our $VERSION = '0.0.3_00';

use base qw/Algorithm::RankAggregate/;

sub get_averagerating_result {
    my ($this, $ranked_lists_list) = @_;
    my @lists_list = ();
    for (my $i = 0; $i <= $#{$ranked_lists_list->[0]}; $i++) {
        my $result = 0;
        for (my $j = 0; $j <= $#{$ranked_lists_list}; $j++) {
            $result = $result + $ranked_lists_list->[$j]->[$i];
        }
        $result = $result / ($#{$ranked_lists_list} + 1);
        push @lists_list, $result;
    }
    return \@lists_list;
}

sub aggregate_rank_to_rating {
    my ($this, $ranked_lists_list) = @_;
    my @result = ();
    if ((exists $this->{weight}) && (exists $this->{weight}->[0])) {
        $ranked_lists_list = $this->get_weighted_count_lists_list($ranked_lists_list);
    }
    @result = @{$this->get_averagerating_result($ranked_lists_list)} if (@{$ranked_lists_list});
    return \@result;
}

sub aggregate_score_to_rating {
    my ($this, $score_lists_list) = @_;
    my @result = ();
    my $ranked_lists_list = $this->get_ranked_lists_list($score_lists_list);
    @result = @{$this->aggregate_rank_to_rating($ranked_lists_list)} if (@{$ranked_lists_list});
    return \@result;

}

sub aggregate {
    my ($this, $score_lists_list) = @_;
    my @result = ();
    return \@result unless ($this->validate_lists_list($score_lists_list));
    @result = @{$this->aggregate_score_to_rating($score_lists_list)} if (@{$score_lists_list});
    return \@result;
}

1;
__END__

=head1 NAME

Algorithm::RankAggregate::AverageRating - Pure Perl implementation of average rating

=head1 SYNOPSIS

    use Algorithm::RankAggregate::AverageRating;

    my @case = (
        [-26.8,  -3.8, -11.2, -9.4, -2.7],
        [-24.8,  18.2, -8.0,  -3.4, 18.0],
        [-17.7,  13.0, -2.4,  -5.7, 12.9],
    );

    my $ar = Algorithm::RankAggregate::AverageRating->new();

    my @result = @{$ar->aggregate(\@case)};

    # in this case, @result = (5, 1.33333333333333, 3.66666666666667, 3.33333333333333, 1.66666666666667)

=head1 DESCRIPTION

Algorithm::RankAggregate::AverageRating is Pure Perl implementation of average rating.
You may read http://en.wikipedia.org/wiki/Borda_count.

=head1 EXPORTED FUNCTIONS

=head2 new()

You can get the instance of this module in following way.

    my $ar = Algorithm::RankAggregate::AverageRating->new();

=head2 new(\@array)

If you want to think of multi voters, you can get the instance of this module in following way.

    my @voters = (42, 26, 15, 17);
    my $ar = Algorithm::RankAggregate::AverageRating->new(\@voters);

If you want to use weighted average rating, you can get the instance of this module in following way.

    my @weights = (0.4, 0.3, 0.2, 0.1);
    my $ar = Algorithm::RankAggregate::AverageRating->new(\@weights);

=head2 aggregate(\@array_of_array)

In first, you should make a array of array which make from real value.

    my @score_lists_list = (
         [-26.8,  -3.8, -11.2, -9.4, -2.7],
         [-24.8,  18.2, -8.0,  -3.4, 18.0],
         [-17.7,  13.0, -2.4,  -5.7, 12.9],
    );

And you can get average ratings in following way.

    my @result = @{$ar->aggregate(\@score_lists_list)};

$ar->aggregate() is simple wrapper of $ar->aggregate_score_to_count();

If you want to use a array of array which make from rank number,
you should call $br->aggregate_rank_to_count();

    my @rank_lists_list = (
         [5, 2, 4, 3, 1],
         [5, 1, 4, 3, 2],
         [5, 1, 3, 4, 2],
    );

=head2 aggregate(\@array_of_array)

When you want to get the average rank value of candidate, you can get average ratings in following way.

    my @result = @{$ar->aggregate(\@score_lists_list)};

$ar->aggregate() is simple wrapper of $ar->aggregate_score_to_count();

=head2 aggregate_score_to_count(\@array_of_array)

This is main function of $ar->aggregate().

=head2 aggregate_rank_to_count(\@array_of_array)

It is called in $ar->aggregate_score_to_count() to get the result average rating array.

=head1 Example

This is example to represent "how to use Algorithm::RankAggregate::AverageRating".

    use Algorithm::RankAggregate::AverageRating;

    # http://en.wikipedia.org/wiki/Borda_count
    # each array of array are (Memphis, Nashville, Chattanooga, Knoxville)
    my @score_lists_list = (
        [4, 3, 2, 1],
        [1, 4, 3, 2],
        [1, 2, 4, 3],
        [1, 2, 3, 4],
    );
    my @voters = (42,26,15,17);
    my $ar = Algorithm::RankAggregate::AverageRating->new(\@voters);
    my @result = @{$ar->aggregate(\@score_lists_list, 3);

    # in this case, @result = (126, 194, 173, 107)

=head1 AUTHOR

Toshinori Sato (@overlast) E<lt>overlasting {at} gmail.comE<gt>

=head1 SEE ALSO

https://github.com/overlast/private/tree/master/lang/perl/CPAN

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
