package Number::Base::SpreadsheetColumn;

use 5.010001;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(
                       from_scbase
                       to_scbase
               );

# AUTHORITY
# DATE
# DIST
# VERSION

sub from_scbase {
    my $str = uc shift;

    die "Please only use letters A-Z" if $str =~ /[^A-Z]/;

    my $res = 0;
    for my $char (split //, $str) {
        $res = $res * 26 + (ord($char) - ord('A') + 1);
    }
    $res-1;
}

sub to_scbase {
    my $num = shift;

    die "Currently can't handle fraction or negative number!"
        if $num < 0 || $num != int($num);
    $num = int($num);

    my $res = "";
    while ($num >= 0) {
        my $remainder = $num % 26;
        my $letter = chr($remainder + ord('A'));
        #say "D:num=<$num>, remainder=<$remainder>, letter=<$letter>";
        $res = $letter . $res;
        $num = int($num / 26) - 1;
        #say "D:num=<$num>";
    }
    $res;
}

1;

# ABSTRACT: Convert spreadsheet column name (e.g. "A", "Z", "AA") to number (e.g. 0, 25, 26) and vice versa

=head1 SYNOPSIS

 use Number::Base::SpreadsheetColumn qw(from_scbase to_scbase);

 say from_scbase("A");  # => 0
 say from_scbase("Z");  # => 25
 say from_scbase("AA"); # => 26
 say from_scbase("AZ"); # => 51
 say from_scbase("BA"); # => 52

 say to_scbase(0);  # => "A"
 say to_scbase(25); # => "Z"
 say to_scbase(26); # => "AA"
 say to_scbase(51); # => "AZ"
 say to_scbase(52); # => "BA"


=head1 DESCRIPTION

Spreadsheet column is basically 26-base number with 1-based index.


=head1 FUNCTIONS

=head2 from_scbase

=head2 to_scbase


=head1 SEE ALSO

L<Number::AnyBase>

=cut
