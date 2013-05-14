package Algorithm::RankAggregate::BordaRank;

use strict;
use warnings;
our $VERSION = '0.0.3_00';

use base qw/Algorithm::RankAggregate::BordaCount/;

sub aggregate_rank_to_rank {
    my ($this, $ranked_lists_list, $top_k_num) = @_;
    my @result = ();
    my $bordacount_result_list = $this->aggregate_rank_to_count($ranked_lists_list, $top_k_num) if (@{$ranked_lists_list});
    @result = @{$this->get_ranked_list($bordacount_result_list)} if (@{$bordacount_result_list});
    return \@result;
}

sub aggregate_score_to_rank {
    my ($this, $score_lists_list, $top_k_num) = @_;
    my @result = ();
    my $ranked_lists_list = $this->get_ranked_lists_list($score_lists_list);
    @result = @{$this->aggregate_rank_to_rank($ranked_lists_list, $top_k_num)} if (@{$ranked_lists_list});
    return \@result;
}

sub aggregate {
    my ($this, $score_lists_list, $top_k_num) = @_;
    my @result = ();
    return \@result unless ($this->validate_lists_list($score_lists_list));
    @result = @{$this->aggregate_score_to_rank($score_lists_list, $top_k_num)} if (@{$score_lists_list});
    return \@result;
}

1;
__END__

=head1 NAME

Algorithm::RankAggregate::BordaRank - Pure Perl implementation of Borda rank

=head1 SYNOPSIS

    use Algorithm::RankAggregate::BordaRank;

    my @case = (
        [-26.8,  -3.8, -11.2, -9.4, -2.7],
        [-24.8,  18.2, -8.0,  -3.4, 18.0],
        [-17.7,  13.0, -2.4,  -5.7, 12.9],
    );

    my $br = Algorithm::RankAggregate::BordaRank->new();

    # give point to attribute which is ranked higher than 4
    my @result = @{$br->aggregate(\@case, 4)};

    # in this case, @result = (5,1,4,3,2)

=head1 DESCRIPTION

Algorithm::RankAggregate::BordaRank is Pure Perl implementation of Borda rank.
You may read http://en.wikipedia.org/wiki/Borda_count.

=head1 EXPORTED FUNCTIONS

=head2 new()

You can get the instance of this module in following way.

    my $br = Algorithm::RankAggregate::BordaRank->new();

=head2 new(\@array)

If you want to think of multi voters, you can get the instance of this module in following way.

    my @voters = (42, 26, 15, 17);
    my $br = Algorithm::RankAggregate::BordaRank->new(\@voters);

If you want to use weighted borda count, you can get the instance of this module in following way.

    my @weights = (0.4, 0.3, 0.2, 0.1);
    my $br = Algorithm::RankAggregate::BordaRank->new(\@weights);

=head2 aggregate(\@array_of_array)

In first, you should make a array of array which make from real value.

    my @score_lists_list = (
         [-26.8,  -3.8, -11.2, -9.4, -2.7],
         [-24.8,  18.2, -8.0,  -3.4, 18.0],
         [-17.7,  13.0, -2.4,  -5.7, 12.9],
    );

And you can get borda rankss in following way.

    my @result = @{$br->aggregate(\@case)};

$br->aggregate() is simple wrapper of $br->aggregate_score_to_rank();

If you want to use a array of array which make from rank number,
you should call $br->aggregate_rank_to_rank();

    my @rank_lists_list = (
         [5, 2, 4, 3, 1],
         [5, 1, 4, 3, 2],
         [5, 1, 3, 4, 2],
    );

=head2 aggregate(\@array_of_array, $positive_int_value)

When you want to rank the candidates which is ranked higher than N(N is a positive natural value), you can get borda ranks in following way.

    my @result = @{$br->aggregate(\@case, N)};

By using this parameter, you can give "N - rank + 1" point to candidate.

$br->aggregate() is simple wrapper of $br->aggregate_score_to_rank();

=head2 aggregate_score_to_rank(\@array_of_array, $positive_int_value)

This is main function of $br->aggregate().

=head2 aggregate_rank_to_rank(\@array_of_array, $positive_int_value)

It is called in $br->aggregate_score_to_rank() to get the result borda rank array.

=head1 Example

This is example to represent "how to use Algorithm::RankAggregate::BordaRank".

    use Algorithm::RankAggregate::BordaRank;

    # http://en.wikipedia.org/wiki/Borda_count
    # each array of array are (Memphis, Nashville, Chattanooga, Knoxville)
    my @score_lists_list = (
        [4, 3, 2, 1],
        [1, 4, 3, 2],
        [1, 2, 4, 3],
        [1, 2, 3, 4],
    );
    my @voters = (42,26,15,17);
    my $br = Algorithm::RankAggregate::BordaRank->new(\@voters);
    my @result = @{$br->aggregate(\@score_lists_list, 3);

    # in this case, @result = (3, 1, 2, 4)
    # because borda count are (126, 194, 173, 107)

=head1 AUTHOR

Toshinori Sato (@overlast) E<lt>overlasting {at} gmail.comE<gt>

=head1 SEE ALSO

https://github.com/overlast/private/tree/master/lang/perl/CPAN

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
