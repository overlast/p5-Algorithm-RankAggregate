package Algorithm::RankAggregate::AverageRank;

use strict;
use warnings;
our $VERSION = '0.0.3_00';

use base qw/Algorithm::RankAggregate::AverageRating/;

sub aggregate_rank_to_rank {
    my ($this, $ranked_lists_list) = @_;
    my @result = ();
    my $bordacount_result_list = $this->aggregate_rank_to_rating($ranked_lists_list) if (@{$ranked_lists_list});
    @result = @{$this->get_reverse_ranked_list($bordacount_result_list)} if (@{$bordacount_result_list});
    return \@result;
}

sub aggregate_score_to_rank {
    my ($this, $score_lists_list) = @_;
    my @result = ();
    my $ranked_lists_list = $this->get_ranked_lists_list($score_lists_list);
    @result = @{$this->aggregate_rank_to_rank($ranked_lists_list)} if (@{$ranked_lists_list});
    return \@result;
}

sub aggregate {
    my ($this, $score_lists_list) = @_;
    my @result = ();
    return \@result unless ($this->validate_lists_list($score_lists_list));
    @result = @{$this->aggregate_score_to_rank($score_lists_list)} if (@{$score_lists_list});
    return \@result;
}

1;
__END__

=head1 NAME

Algorithm::RankAggregate::AverageRank - Pure Perl implementation of average rank

=head1 SYNOPSIS

    use Algorithm::RankAggregate::AverageRank;

    my @case = (
        [-26.8,  -3.8, -11.2, -9.4, -2.7],
        [-24.8,  18.2, -8.0,  -3.4, 18.0],
        [-17.7,  13.0, -2.4,  -5.7, 12.9],
    );

    my $ar = Algorithm::RankAggregate::AverageRank->new();

    # give point to attribute which is ranked higher than 4
    my @result = @{$ar->aggregate(\@case, 4)};

    # in this case, @result = (5,1,4,3,2)

=head1 DESCRIPTION

Algorithm::RankAggregate::AverageRank is Pure Perl implementation of average rank.
You can get ranking list based of average rank number.

You may read http://en.wikipedia.org/wiki/Borda_count.

=head1 EXPORTED FUNCTIONS

=head2 new()

You can get the instance of this module in following way.

    my $ar = Algorithm::RankAggregate::AverageRank->new();

=head2 new(\@array)

If you want to think of multi voters, you can get the instance of this module in following way.

    my @voters = (42, 26, 15, 17);
    my $ar = Algorithm::RankAggregate::AverageRank->new(\@voters);

If you want to use weighted borda count, you can get the instance of this module in following way.

    my @weights = (0.4, 0.3, 0.2, 0.1);
    my $ar = Algorithm::RankAggregate::AverageRank->new(\@weights);

=head2 aggregate(\@array_of_array)

In first, you should make a array of array which make from real value.

    my @score_lists_list = (
         [-26.8,  -3.8, -11.2, -9.4, -2.7],
         [-24.8,  18.2, -8.0,  -3.4, 18.0],
         [-17.7,  13.0, -2.4,  -5.7, 12.9],
    );

And you can get average rankss in following way.

    my @result = @{$ar->aggregate(\@case)};

$ar->aggregate() is simple wrapper of $ar->aggregate_score_to_rank();

If you want to use a array of array which make from rank number,
you should call $ar->aggregate_rank_to_rank();

    my @rank_lists_list = (
         [5, 2, 4, 3, 1],
         [5, 1, 4, 3, 2],
         [5, 1, 3, 4, 2],
    );

=head2 aggregate(\@array_of_array, $positive_int_value)

When you want to rank the candidates, you can get average ranks in following way.

    my @result = @{$ar->aggregate(\@case)};

$ar->aggregate() is simple wrapper of $ar->aggregate_score_to_rank();

=head2 aggregate_score_to_rank(\@array_of_array)

This is main function of $ar->aggregate().

=head2 aggregate_rank_to_rank(\@array_of_array)

It is called in $ar->aggregate_score_to_rank() to get the result average rank array.

=head1 Example

This is example to represent "how to use Algorithm::RankAggregate::AverageRank".

    use Algorithm::RankAggregate::AverageRank;

    # http://en.wikipedia.org/wiki/Borda_count
    # each array of array are (Memphis, Nashville, Chattanooga, Knoxville)
    my @score_lists_list = (
        [4, 3, 2, 1],
        [1, 4, 3, 2],
        [1, 2, 4, 3],
        [1, 2, 3, 4],
    );
    my @voters = (42,26,15,17);
    my $ar = Algorithm::RankAggregate::AverageRank->new(\@voters);
    my @result = @{$ar->aggregate(\@score_lists_list);

    # in this case, @result = (3, 1, 2, 4)
    # because borda count are (68.5, 51.5, 56.75, 73.25)

=head1 AUTHOR

Toshinori Sato (@overlast) E<lt>overlasting {at} gmail.comE<gt>

=head1 SEE ALSO

https://github.com/overlast/private/tree/master/lang/perl/CPAN

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
